#
# New_TestProject.ps1
#

Function New-TestProject {
	Param (
		$Template,
		[string] $Path = $testDrive
	)

	Foreach ($file in Get-ChildItem $Template.Path -Recurse) {
		Write-Debug $file.FullName
	}

	$project = @{
		"Name" = $Template.Name
		"Path" = $Path
		"ServerInstance" = $Template.ServerInstance
	}

	$project
}