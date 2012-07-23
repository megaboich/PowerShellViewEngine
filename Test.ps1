. '.\ViewEngineTool.ps1'


function test()
{
	#test model
	$Model = @{}
	$Model.Title = 'Hello, this is a test'
	$Model.Clients = @('Ivan', 'Sergiy', 'John')
	
	#view render method 1 - embedded powershell string evaluation
	$html = "
	<h1>
		$($Model.Title)
	</h1>
	<div class=""test"">
		<ul>
			 $( foreach($client in $Model.Clients) {"
				<li>
					$( $client )
				</li>
			"})
		</ul>
	</div>"
	Write-Host $html
	
	#view render method 2 - templates powershell evaluation
	RenderViewNativePowerShell 'Test_ps.html' $Model
	
	#view render method 3 - ASP-syntax templates powershell evaluation
	RenderView 'Test.html' $Model
}

test