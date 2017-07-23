Import-Module "$PSScriptRoot\.." -Force -Verbose

. "$PSScriptRoot\Helper\New-TestProject.ps1"

Describe "New-Script" {
	BeforeEach {
		$projectName = "EmptyPSProject"
		$projectPath = "$PSScriptRoot/$projectName"

		$project = New-TestProject -Name $projectName -Path $projectPath
	}

	AfterEach {
	}

	Context "Exists" {
		It "Runs" {
			$script = New-Script -Name "Test" -Type "SQL" -Project $project

			$script.Name | Should be "Test"
			$script.FullName | Should exist
			$script.FullName | Should beLike "*.sql"
		}
	}
}