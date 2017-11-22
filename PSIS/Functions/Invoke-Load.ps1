#
# Invoke-Load.ps1
#
Function Invoke-Load {
    Param (
        $Load
    )

    Write-Verbose "Invoke Load with the following parameters:"
    ConvertTo-Json $Load | Write-Verbose

    $result = $Load.Scripts | Sort-Object | ForEach-Object {

        Write-Verbose "Invoke-Load: Next Script is $( $_.Path )"

        $scriptResult = Invoke-Script -Script $_ -ServerInstance $Load.ServerInstance

        Write-Verbose "Invoke-Load: result of $( $_.Path ) is:"
        ConvertTo-Json $scriptResult | Write-Verbose
        
        $scriptResult

        If ( $scriptResult.ReturnCode -ne [ScriptReturnCode]::Success ) {
            break
        }
    }

    , @($result)
}