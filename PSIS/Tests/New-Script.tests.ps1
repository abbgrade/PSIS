Import-Module "$PSScriptRoot\.." -Force -Verbose

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
			$script = New-Script -Name "Test" -Type "SQL" -Project $project

			$script.Name | Should be "Test"
			$script.Type | Should be "SQL"
			$script.FullName | Should exist
			$script.FullName | Should beLike "*.sql"
		}
	}
}