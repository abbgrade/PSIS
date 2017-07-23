#
# Get_Script.ps1
#

Function Get-Script {
	Param (
		[string] $Path
	)

	$Path = ( Get-Item -Path $Path ).FullName

	$script = @{
		"Path" = $Path
	}

	$script
}