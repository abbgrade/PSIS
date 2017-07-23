Import-Module "$PSScriptRoot\.." -Force -Verbose

Describe "Get-Project" {
	It "Returns a valid project." {
		$projectName = "EmptyPSProject"
		$projectPath = "$PSScriptRoot/$projectName"

		$project = Get-Project -Name $projectName -Path $projectPath -ServerInstance "Test"
		$project.Name | Should be $projectName
		$project.Path | Should be $projectPath
		$project.ServerInstance | Should be "Test"
	}
}