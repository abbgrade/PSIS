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
						-Path $projectPath `
						-ServerInstance '(localdb)\ProjectsV12'
				)
		}
		It "Invokes a load" {
			$load = New-Load -Project $project
			$result = Invoke-Load -Load $load

			$result.Count | Should be $project.Scripts.Count
			$result.Count | Should be 1

			$result | ForEach-Object {
				$_.ReturnCode | Should be Success
			}
		}
		It "Invokes a load with SQL" {
			$script = New-Script `
				-Name "Test.sql" `
				-Project $project
			"SELECT 42 AS value;" | Set-Content -Path $script.Path

			$project = Get-Project `
				-Name $project.Name `
				-Path $project.Path `
				-ServerInstance $project.ServerInstance

			$load = New-Load -Project $project
			$result = Invoke-Load -Load $load

			#ConvertTo-Json $result | Write-Verbose -Verbose

			$result.Count | Should be $project.Scripts.Count
			$result.Count | Should be 2

			$result | ForEach-Object {
				$_.ReturnCode | Should be Success
			}
		}
	}
}