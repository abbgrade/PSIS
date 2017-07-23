Import-Module "$PSScriptRoot\.."

. "$PSScriptRoot\Helper\New-TestProject.ps1"

Describe "Invoke-Load" {
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
		It "Invokes a load" {
			$load = New-Load -Project $project
			$result = Invoke-Load -Load $load

            ConvertTo-Json $result | Write-Host

			$result.Count | Should be $project.Scripts.Count
		}
	}
}