<h2>What is callAction()?</h2>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="4">callAction()</th>
	</tr>
	<tr valign="top">
		<th>Argument</th>
		<th>Type</th>
		<th>Required?</th>
		<th>Description</th>
	</tr>
	<tr valign="top">
		<td>actionName</td>
		<td>string</td>
		<td>Required</td>
		<td>
			The name of the action you want to call.<br /><br />
			In multiple controllers or assigned controllers:<br />
			controllerName + actionDelimiter (&quot;.&quot; is the default) + actionName<br />
			e.g. home.welcome
		</td>
	</tr>
	<tr valign="top">
		<td>args</td>
		<td>any</td>
		<td>Optional</td>
		<td>
			Any data you want to pass into the action.
		</td>
	</tr>
</table>