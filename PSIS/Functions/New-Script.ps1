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
		"FullName" = "$($Project.Path)/$Name.$($Type.ToLower())"
	}

	Set-Content $script.FullName -Value "Test"

	$script
}