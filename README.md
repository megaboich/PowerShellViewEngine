PowerShellViewEngine
====================

Simple view engine for PowerShell, supports ASP-like formatting

To try it out, just run the test.ps1

Sample of view template:
<pre>

<% RenderView "header.html" $Model %>

<div class="test">
	<ul>
		 <% foreach($client in $Model.Clients) {%>
			<li>
				<% $client %>
			</li>
		<%}%>
	</ul>
</div>

</pre>
