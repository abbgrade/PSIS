Import-Module "$PSScriptRoot\.." -Force

Describe "Get-Project" {
    Context "Test Project" {
        BeforeEach {
            $projectName = "EmptyPSProject"
            $projectPath = "$PSScriptRoot/$projectName"
        }

        It "Returns a project" {
            $project = Get-Project `
                -Name $projectName `
                -Path $projectPath `
                -ServerInstance "Test"

            $project.Name | Should be $projectName
            $project.Path | Should be ( Get-Item $projectPath ).FullName
            $project.ServerInstance | Should be "Test"

            $project.Scripts.Count | Should be 1
        }

        It "Returns a project with separate scripts dir" {
            $scriptsPath = $testDrive

            $project = Get-Project `
                -Name $projectName `
                -Path $projectPath `
                -ScriptsPath $scriptsPath `
                -Verbose

            $project.Scripts.Count | Should be 0
        }
    }
}