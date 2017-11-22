Import-Module "$PSScriptRoot\.."

. "$PSScriptRoot\Helper\New-TestProject.ps1"

Describe "New-Script" {
    Context "Test project" {
        BeforeEach {
            $projectName = "EmptyPSProject"
            $projectPath = "$PSScriptRoot\$projectName"
            $project = New-TestProject -Template (
                Get-Project `
                    -Name $projectName `
                    -Path $projectPath
            )
        }
        It "Create new SQL script" {
            $script = New-Script `
                -Name "Test.sql" `
                -Project $project

            $script.Name | Should be "Test.sql"
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