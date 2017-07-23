Import-Module "$PSScriptRoot\.." -Force -Verbose

Describe "Get-Project" {
	Context "Exists" {
		It "Runs" {
			$projectName = "EmptyPSProject"
			$projectPath = "$PSScriptRoot/$projectName"

			$project = Get-Project -Name $projectName -Path $projectPath
			$project.Name | Should be $projectName
			$project.Path | Should be $projectPath
		}
	}
}