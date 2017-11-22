#
# New-Load.ps1
#

Function New-Load {
	Param (
		$Project
	)

	@{
		"Scripts" = $Project.Scripts
		"ServerInstance" = $Project.ServerInstance
	}
}