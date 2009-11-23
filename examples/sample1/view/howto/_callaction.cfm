<h2>callAction()</h2>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="4">callAction() (available in 0.4.3; replaces callEvent() in 0.4.4.)</th>
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
			In multiple controllers or assigned classes:<br />
			className + actionDelimiter (0.4.4) + methodName<br />
			e.g. actionName=&quot;home.welcome&quot; is a valid value here. callAction(&quot;home.welcome&quot;) is the equivalent of calling ?do=home.welcome.</td>
	</tr>
	<tr valign="top">
		<td>args</td>
		<td>any</td>
		<td>Optional</td>
		<td>
			Any data you want to pass into the action.
		Each action can also access request.attributes, so you don't need to pass in arguments unless you're passing in something not in the request scope (though this breaks encapsulation).</td>
	</tr>
</table>