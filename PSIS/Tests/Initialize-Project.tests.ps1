Import-Module "$PSScriptRoot\.." -Force -Verbose

Describe "Initialize-Project" {
	Context "Exists" {
		It "Runs" {
			$projectName = "EmptyPSProject"
			$projectPath = "$PSScriptRoot/$projectName"

			Initialize-Project -Name $projectName -Path $projectPath | Should be
		}
	}
}