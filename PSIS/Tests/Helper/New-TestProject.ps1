#
# New-TestProject.ps1
#
Import-Module "$PSScriptRoot\..\.." -Force

Function New-TestProject {
	Param (
		$Template,
		[string] $Path = $testDrive
	)

	$Path = ( Get-Item $Path ).FullName

	Write-Verbose "New test project in $Path from $( $Template.Path )"

	Get-ChildItem $Template.Path -Recurse | ForEach-Object {
		$file = $_

		Copy-Item `
			-Path $file.FullName `
			-Destination $file.FullName.Replace($Template.Path, $Path) `
			-Force
	}

	Get-Project `
		-Name $Template.Name `
		-Path $Path `
		-ServerInstance $Template.ServerInstance
}