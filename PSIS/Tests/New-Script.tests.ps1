Import-Module "$PSScriptRoot\.."

. "$PSScriptRoot\Helper\New-TestProject.ps1"

Describe "New-Script" {
	BeforeEach {
		$projectName = "EmptyPSProject"
		$projectPath = "$PSScriptRoot\$projectName"

		$project = New-TestProject `
			-Template (
				Get-Project `
					-Name $projectName `
					-Path $projectPath
			)
	}

	Context "Test project" {
		It "Create new SQL script" {
			$script = New-Script `
				-Name "Test" `
				-Type "SQL" `
				-Project $project

			$script.Name | Should be "Test"
			$script.Type | Should be "SQL"
			$script.Path | Should exist
			$script.Path | Should beLike "*.sql"

			$project = Get-Project `
				-Name $project.Name `
				-Path $project.Path `
				-ServerInstance $project.ServerInstance

			( $project.Scripts | Where-Object { $_.Path.Endswith('Test.sql') }).Count | Should be 1
		}
	}
}