#
# Invoke_Load.ps1
#
Function Invoke-Load {
	Param (
		$Load
	)

	Write-Verbose "Invoke Load:"
	ConvertTo-Json $Load | Write-Verbose

	$result = $Load.Scripts | Sort Path | Foreach {
		$scriptResult = Invoke-Script -Script $_ -ServerInstance $Load.ServerInstance
		$scriptResult
		If ( $scriptResult.ReturnCode -ne [ScriptReturnCode]::Success ) {
			break
		}
	}

	, @($result)
}