Import-Module "$PSScriptRoot\..\.." -Force -Verbose

. "$PSScriptRoot\New-TestProject.ps1"

Describe "New-TestProject" {
	Context "Create test project" {
		It "Runs from template" {
			$projectName = "EmptyPSProject"
			$projectPath = "$PSScriptRoot\..\$projectName"

			$template = Get-Project -Name $projectName -Path $projectPath -ServerInstance "Test"

			$copy = New-TestProject -Template $template

			$copy.Name | Should be $template.Name
			$copy.ServerInstance | Should be "Test"
		}
	}
}