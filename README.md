PowerShellViewEngine
====================

Simple view engine for PowerShell, supports ASP-like formatting

To try it out, just run the test.ps1

Sample of view template:
```html

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

```

Full story of this module you can find in my blog: https://olekboiko.com/posts/2012-08-06-PowerShell-View-Engine-Asp-style/
