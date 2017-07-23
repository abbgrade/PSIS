#
# Get_Project.ps1
#

Function Get-Project {
	Param (
		[string] $Name,
		[string] $Path,
		[string] $ServerInstance
	)

	If (-Not ( Test-Path $Path -PathType Container )) {
		Write-Error "$( $Path ) does not exist."
	}

	$project = @{
		"Name" = $Name
		"Path" = $Path
		"ServerInstance" = $ServerInstance
	}

	$project
}