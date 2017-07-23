#
# Get_Project.ps1
#

Function Get-Project {
	Param (
		[string] $Name,
		[string] $Path,
		[string] $ServerInstance
	)

	$Path = ( Get-Item -Path $Path ).FullName

	$scripts = Get-ChildItem $Path -Recurse `
		| Foreach { Get-Script -Path $_.FullName } `
		| Sort Path

	$project = @{
		"Name" = $Name
		"Path" = $Path
		"ServerInstance" = $ServerInstance
		"Scripts" = $scripts
	}

	$project
}