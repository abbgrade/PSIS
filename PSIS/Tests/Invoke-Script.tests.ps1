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
				-Name "Test 1.sql" `
				-Project $project

			"SELECT 42 AS value;" | Set-Content -Path $script.Path

			$result = Invoke-Script `
				-Script $script `
				-ServerInstance $project.ServerInstance

			$result.ReturnCode | Should be Success
		}

		It "Invokes a faulty SQL script" {
			$script = New-Script `
				-Name "Test 2.sql" `
				-Project $project

			"this is invalid!" | Set-Content -Path $script.Path

			$result = Invoke-Script `
				-Script $script `
				-ServerInstance $project.ServerInstance

			$result.ReturnCode | Should be RuntimeError
		}

		It "Invokes a SQL without Server" {
			$project.ServerInstance = $null
			$script = New-Script `
				-Name "Test 3.sql" `
				-Project $project

			"SELECT 42 AS value;" | Set-Content -Path $script.Path

			$result = Invoke-Script `
				-Script $script `
				-ServerInstance $project.ServerInstance

			$result.ReturnCode | Should be InvalidArgument
		}

		It "Invokes a SQL script with GO" {
			$script = New-Script `
				-Name "Test 4.sql" `
				-Project $project

			"SELECT 42 AS value
			GO
			SELECT 43 AS another" | Set-Content -Path $script.Path

			$result = Invoke-Script `
				-Script $script `
				-ServerInstance $project.ServerInstance

			$result.ReturnCode | Should be Success
		}

		It "Invokes a SQL script with INSERT" {
			$script = New-Script `
				-Name "Test 4.sql" `
				-Project $project

			"CREATE TABLE #test (mycol INT);
			GO

			INSERT INTO #TEST
			SELECT 42;" | Set-Content -Path $script.Path

			$result = Invoke-Script `
				-Script $script `
				-ServerInstance $project.ServerInstance

			$result.ReturnCode | Should be Success
		}
	}
}