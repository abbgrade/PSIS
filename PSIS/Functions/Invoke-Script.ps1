#
# Invoke_Script.ps1
#

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
		"Script" = $Script
		"ReturnCode" = [ScriptReturnCode]::Undefined
		"Error" = $null
	}

	$type = $Script.Path.Split(".")[-1].ToUpper()
	Try {
		Switch ($type) {
			"SQL" {
				Write-Verbose "Invoke '$($Script.Path)' as SQL script"

				If ( -not $ServerInstance) {
					$result.ReturnCode = [ScriptReturnCode]::InvalidArgument
					Write-Error "Parameter -ServerInstance is required for SQL scripts."
					break
				}

				$sqlResult = Invoke-Sqlcmd2 -ServerInstance $ServerInstance -InputFile $Script.Path
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
		Write-Warning "Script '$($result.Script.Path)' returned with code '$($result.ReturnCode)': '$($result.Error)'"
	}

	$result
}