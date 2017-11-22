#
# Invoke-Script.ps1
#

Add-Type -Path "C:\Program Files\Microsoft SQL Server\120\SDK\Assemblies\Microsoft.SqlServer.Smo.dll"

Import-Module dbatools
If (-not ([System.Management.Automation.PSTypeName]'ScriptReturnCode').Type) {
    Add-Type -TypeDefinition @"
	public enum ScriptReturnCode
	{
		Undefined,
		Success,
		NotImplemented,
		InvalidArgument,
		RuntimeError
	}
"@
}

Function Invoke-Script {
    Param (
        $Script,
        [string] $ServerInstance
    )

    $result = @{
        "Script"     = $Script
        "ReturnCode" = [ScriptReturnCode]::Undefined
        "Error"      = $null
        "StartTime"  = Get-Date
    }

    Write-Debug "$( $result.StartTime ) Start $( $Script.Path )"

    $type = $Script.Path.Split(".")[-1].ToUpper()
    Try {
        Switch ($type) {
            "SQL" {
                Write-Verbose "Invoke '$( $Script.Path )' as SQL script"

                If ( -not $ServerInstance ) {
                    $result.ReturnCode = [ScriptReturnCode]::InvalidArgument
                    Throw "Parameter -ServerInstance is required for SQL scripts."
                }

                $sqlSource = Get-Content -Path $Script.Path | Out-String
                $sqlServer = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $ServerInstance
                $sqlServer.ConnectionContext.StatementTimeout = 0

                Try {
                    $sqlServer.ConnectionContext.ExecuteNonQuery($sqlSource)
                }
                Catch {
                    If ($_.Exception.InnerException.Message -eq "An exception occurred while executing a Transact-SQL statement or batch.") {
                        Throw $_.Exception.InnerException.InnerException.Message
                    }
                    Else {
                        Write-Verbose $_.Exception.InnerException.Message

                        Write-Warning $_
                        Throw $_
                    }
                }

                $result.ReturnCode = [ScriptReturnCode]::Success
            }
            "PS1" {
                Write-Verbose "Invoke '$($Script.Path)' as Powershell script"
                . $Script.Path
                $result.ReturnCode = [ScriptReturnCode]::Success
            }
            default {
                $result.ReturnCode = [ScriptReturnCode]::NotImplemented
                $result.Error = "Script type '$type' is not implemented."
            }
        }
    }
    Catch {
        If ($result.ReturnCode -ne [ScriptReturnCode]::InvalidArgument) {
            $result.ReturnCode = [ScriptReturnCode]::RuntimeError
        }
        $result.Error = $_.Exception.Message
    }

    If ($result.ReturnCode -ne [ScriptReturnCode]::Success) {
        Write-Warning "$($result.ReturnCode) in Script '$($result.Script.Path)': '$($result.Error)'"
    }

    $result.StopTime = Get-Date

    Write-Debug "$( $result.StopTime ) Stop $( $Script.Path )"

    $result
}