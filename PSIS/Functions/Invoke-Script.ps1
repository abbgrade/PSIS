#
# Invoke_Script.ps1
#

Import-Module dbatools

Function Invoke-Script {
	Param (
		$Script,
		[string] $ServerInstance
	)

	$result = @{
		"Script" = $Script
		"ReturnCode" = $null
		"Error" = $null
	}

	$type = $Script.Path.Split(".")[-1].ToUpper()
	Try {
		Switch ($type) {
			"SQL" {
				Write-Verbose "Invoke '$($Script.Path)' as SQL script"
				$execution = Invoke-Sqlcmd2 -ServerInstance $ServerInstance -InputFile $Script.Path
				$result.ReturnCode = 0
			}
			"PS1" {
				Write-Verbose "Invoke '$($Script.Path)' as Powershell script"
				. $Script.Path
				$result.ReturnCode = 0
			}
			default {
				$result.ReturnCode = 1
				$result.Error = "Script type $type is not implemented."
				Write-Warning $result.Error
			}
		}
	}
	Catch {
		$result.ReturnCode = 2
		$result.Error = $_.Message
		Write-Warning $result.Error
	}

	If ($result.ReturnCode -ne 0) {
		Write-Error $result.ReturnCode $result.Error
	}

	$result
}