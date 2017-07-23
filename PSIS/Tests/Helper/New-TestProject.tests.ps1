Import-Module "$PSScriptRoot\..\.." -Force -Verbose

. "$PSScriptRoot\New-TestProject.ps1"

Describe "New-TestProject" {
	Context "Exists" {
		It "Runs" {
			$projectName = "EmptyPSProject"
			$projectPath = "$PSScriptRoot/$projectName"

			$template = Get-Project -Name $projectName -Path $projectPath

			$copy = New-TestProject -Name $projectName -Path $projectPath

			$copy.Name | Should be $template.Name
		}
	}
}