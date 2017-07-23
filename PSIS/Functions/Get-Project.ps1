#
# Get_Project.ps1
#

Function Get-Project {
	Param (
		[string] $Name,
		[string] $Path
	)

	If (Test-Path $Path) {
		Write-Error "$( $Path ) does not exist."
	}

	$project = @{
		"Name" = $Name
		"Path" = $Path
	}

	$project
}