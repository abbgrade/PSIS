#
# Get-Project.ps1
#

Function Get-Project {
    Param (
        [string] $Name,
        [string] $Path,
        [string] $ScriptsPath,
        [string] $ServerInstance
    )

    $Path = ( Get-Item -Path $Path ).FullName
    Write-Verbose "Get-Project from Path: $Path"

    If ( -not $ScriptsPath ) {
        $ScriptsPath = $Path
    }
    $ScriptsPath = ( Get-Item -Path $ScriptsPath ).FullName
    Write-Verbose "Get-Project with ScriptPath: $ScriptsPath"

    $scripts = Get-ChildItem $ScriptsPath -Recurse `
        | ForEach-Object { Get-Script -Path $_.FullName } `
        | Where-Object { @('SQL', 'PS1') -contains $_.Path.Split(".")[-1].ToUpper() } `
        | Sort-Object Path

    $project = @{
        "Name"           = $Name
        "Path"           = $Path
        "ServerInstance" = $ServerInstance
        "Scripts"        = $scripts
    }

    $project
}