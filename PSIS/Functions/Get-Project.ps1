#
# Get_Project.ps1
#

Function Get-Project {
	Param (
		[string] $Name,
		[string] $Path
	)

	$project = @{
		"Name" = $Name
		"Path" = $Path
	}

	$project
}