Import-Module "$PSScriptRoot\.." -Force -Verbose

Describe "New-Script" {
	BeforeEach {
		$projectName = "EmptyPSProject"
		$projectPath = "$PSScriptRoot/$projectName"
		$project = Get-Project -Name $projectName -Path $projectPath
	}

	Context "Exists" {
		It "Runs" {
			$script = New-Script -Name "Test" -Project $project

			$script.Name | Should be "Test"
			$script.FullName | Should exist
		}
	}
}