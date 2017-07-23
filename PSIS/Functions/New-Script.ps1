#
# New_Script.ps1
#

Function New-Script {
	Param (
		[string] $Name,
		$Project
	)

	If (Test-Path $Project.Path) {
		Write-Error "$( $Project.Path ) does not exist."
	}

	$script = @{
		"Name" = $Name
		"FullName" = "$($Project.Path)/$Name.$Type"
	}

	Set-Content $script.FullName -Value "Test"

	$script
}