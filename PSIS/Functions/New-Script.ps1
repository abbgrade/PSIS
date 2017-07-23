#
# New_Script.ps1
#

Function New-Script {
	Param (
		[string] $Name,
		$Project
	)

	$script = @{
		"Name" = $Name
		"FullName" = "$($Project.Path)/$Name.$Type"
	}

	Set-Content $script.FullName -Value "Test"

	$script
}