#
# New_Script.ps1
#

Function New-Script {
	Param (
		[string] $Name,
		[string] $Type,
		$Project
	)

	$script = @{
		"Name" = $Name
		"Type" = $Type
		"Path" = "$($Project.Path)\$Name.$($Type.ToLower())"
	}

	Set-Content $script.Path -Value "Test"

	$script
}