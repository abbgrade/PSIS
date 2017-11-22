Import-Module "$PSScriptRoot\.." -Force

. "$PSScriptRoot\Helper\New-TestProject.ps1"

Describe "Get-Script" {
    BeforeEach {
        $projectName = "EmptyPSProject"
        $projectPath = "$PSScriptRoot\$projectName"
        $project = New-TestProject -Template (
            Get-Project `
                -Name $projectName `
                -Path $projectPath
        )
    }
    Context "Test Project" {
        It "Returns a script" {
            $scriptPath = "$projectPath\Script.ps1"
            $script = Get-Script -Path $scriptPath
            $script.Path | Should be $scriptPath
        }
    }
}