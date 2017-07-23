Import-Module "$PSScriptRoot\.." -Force

. "$PSScriptRoot\Helper\New-TestProject.ps1"

Describe "Invoke-Script" {
	BeforeEach {
		$projectName = "EmptyPSProject"
		$projectPath = "$PSScriptRoot/$projectName"

		$project = New-TestProject `
			-Template (
				Get-Project `
					-Name $projectName `
					-Path $projectPath `
					-ServerInstance '(localdb)\ProjectsV12'
			)
	}

	Context "Test project" {
		It "Invokes a simple SQL script" {
			$script = New-Script `
				-Name "Test.sql" `
				-Project $project

			"SELECT 42 AS value;" | Set-Content -Path $script.Path

			$result = Invoke-Script `
				-Script $script `
				-ServerInstance $project.ServerInstance

			$result.ReturnCode | Should be 0
		}
	}
}