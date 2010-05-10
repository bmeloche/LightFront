<h2>What is displayView()?</h2>
<p>displayView()... wait for it... displays your views! Pretty simple, huh?</p>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="4">displayView()</th>
	</tr>
	<tr valign="top">
		<th>Argument</th>
		<th>Type</th>
		<th>Required?</th>
		<th>Description</th>
	</tr>
	<tr valign="top">
		<td>viewname</td>
		<td>string</td>
		<td>Required</td>
		<td>
			The name of the view you want to call.<br /><br />
			In multiple controllers or assigned controlleres:<br />
			controllerName + actionDelimiter + actionName<br />
			e.g. home.welcome<br />
			<br />
			You can also use a / instead of your actionDelimiter. home/welcome also works in LightFront.<br />
			<br />
			Another added feature is the ability to go more than two levels deep. <a href="#link('test.threedeep.test')#">Try this for an example</a>.
		</td>
	</tr>
	<tr valign="top">
		<td>content</td>
		<td>any</td>
		<td>Optional</td>
		<td>Any data you want to pass into the view. You can pass content to the view just by using the variables or the request scope.</td>
	</tr>
</table>