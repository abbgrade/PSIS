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
		"Path" = "$($Project.Path)\$Name"
	}

	Set-Content $script.Path -Value "Test"

	$script
}