Import-Module "$PSScriptRoot\.." -Force -Verbose

Describe "Get-Project" {
	Context "Exists" {
		It "Runs" {
			$projectName = "EmptyPSProject"
			$projectPath = "$PSScriptRoot/$projectName"
			Get-Project -Name $projectName -Path $projectPath | Should be
		}
	}
}