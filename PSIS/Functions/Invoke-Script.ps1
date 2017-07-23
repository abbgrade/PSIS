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

	Write-Host $Script.FullName

	Try {
		Switch ($Script.Type) {
			"SQL" {
				Write-Verbose "Invoke as SQL"
				$execution = Invoke-Sqlcmd2 -ServerInstance $ServerInstance -InputFile $Script.FullName
				$result.ReturnCode = 0
			}
			default {
				$result.ReturnCode = 1
				$result.Error = "Script type $( $Script.Type ) is not implemented."
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