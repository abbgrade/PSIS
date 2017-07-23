#
# New_Script.ps1
#

Function New-Script {
	Param (
		[string] $Name
	)

	$script = @{
		"Name" = $Name
		"FullName" = "$($Project.Path)/$Name.$Type"
	}

	$script
}