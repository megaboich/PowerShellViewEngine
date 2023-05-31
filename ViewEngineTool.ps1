
function RenderViewNativePowerShell(
	[Parameter(Mandatory=$true)][string] $viewName,
	[Parameter(Mandatory=$true)][Object] $model
)
{
	$viewFileName = Resolve-Path ('Views\' + $viewName)
	$templateContent = Get-Content $viewFileName -encoding UTF8 | Out-String
	return $ExecutionContext.InvokeCommand.ExpandString($templateContent)
}

function RenderView(
	[Parameter(Mandatory=$true)][string] $viewName,
	[Parameter(Mandatory=$true)][Object] $model
)
{
	$viewFileName = Resolve-Path ('Views\' + $viewName)
	$templateContent = Get-Content $viewFileName | Out-String
	
	$rx = New-Object System.Text.RegularExpressions.Regex('(<%.*?%>)', [System.Text.RegularExpressions.RegexOptions]::Singleline)
	$res = @()
	$splitted = $rx.Split($templateContent);
	foreach($part in $splitted)
	{
		if ($part.StartsWith('<%') -and $part.EndsWith('%>')) #transform <%...%> blocks
		{	
			$expr = $part.Substring(2, $part.Length-4) #remove <%%>
			$normExpr = $expr.Replace('`n','').Replace('`r','').Trim();
			
			$startClosure = '$('
			$endClosure = ')'
			if ($normExpr.EndsWith('{')) {
				$endClosure = '"'
			}
			if ($normExpr.StartsWith('}')) {
				$startClosure = '"'
			}
			$expr = $expr.Replace('""', "''")	#replace "" to '' - prevents error while evaluating template
			$res += @($startClosure + $expr + $endClosure)
		}
		else #encode text blocks
		{
			$expr = $part.Replace('"', '~dblqt~');
			$res += @($expr)
		}
	}
	$viewExpr = $res -join ''
	return $ExecutionContext.InvokeCommand.ExpandString('"' + $viewExpr + '"').Replace('~dblqt~', '"')
}



