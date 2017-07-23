#
# New_TestProject.ps1
#

Function New-TestProject {
	Param (
		[string] $Name,
		[string] $Path
	)

	Foreach ($file in Get-ChildItem $Path -Recurse) {
		Write-Debug $file.FullName
	}

	$project = @{
		"Name" = $Name
		"Path" = "TestDrive:"
	}

	$project
}