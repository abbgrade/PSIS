#
# New_Load.ps1
#

Function New-Load {
	Param (
		$Project
	)

	@{
		"Scripts" = $Project.Scripts
	}
}