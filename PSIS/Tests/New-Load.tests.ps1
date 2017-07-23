Import-Module "$PSScriptRoot\.."

. "$PSScriptRoot\Helper\New-TestProject.ps1"

Describe "New-Load" {
	Context "Test Project" {
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
		It "Create a new load" {
			$load = New-Load -Project $project

			$load.Scripts.Count | Should be $project.Scripts.Count

			ForEach ( $script in $project.Scripts ) {
				$load.Scripts -contains $script | Should be $true
			}
		}
	}
}