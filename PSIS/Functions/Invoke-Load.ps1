#
# Invoke_Load.ps1
#
Function Invoke-Load {
	Param (
		$Load
	)

	Write-Verbose "Invoke Load:"
	ConvertTo-Json $Load | Write-Verbose

	$result = $Load.Scripts | Foreach {
		Invoke-Script -Script $_ -ServerInstance $Load.ServerInstance
	}

	, @($result)
}