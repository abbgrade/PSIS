Import-Module "$PSScriptRoot\.." -Force

Describe "Get-Project" {
	It "Returns a project." {
		$projectName = "EmptyPSProject"
		$projectPath = "$PSScriptRoot/$projectName"

		$project = Get-Project `
			-Name $projectName `
			-Path $projectPath `
			-ServerInstance "Test"

		$project.Name | Should be $projectName
		$project.Path | Should be ( Get-Item $projectPath ).FullName
		$project.ServerInstance | Should be "Test"

		( $project.Scripts | Where-Object { $_.Path.Endswith('.ps1') }).Count | Should be 1

		$script = Get-Script -Path "$projectPath\Script.ps1"
	}
}