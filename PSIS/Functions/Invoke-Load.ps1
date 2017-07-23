#
# Invoke_Load.ps1
#
Function Invoke-Load {
	Param (
		$Load
	)

	$result = $Load.Scripts | Foreach {
		Invoke-Script -Script $_
	}

	, @($result)
}