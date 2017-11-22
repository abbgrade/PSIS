Import-Module "$PSScriptRoot\.." -Force

Describe "Initialize-Project" {
    It "Initializes a Visual Studio project" {
        $projectName = "EmptyPSProject"
        $projectPath = "$PSScriptRoot/$projectName"

        Initialize-Project -Name $projectName -Path $projectPath | Should be
    }
}