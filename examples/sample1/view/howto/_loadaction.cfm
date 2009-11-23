<h2>loadAction()</h2>
<p>Loads a callAction() and saves it directly to the variable name passed request variable name of your choosing.</p>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="4">loadAction(requestVar, actionName, args) return void (creates request[arguments.requestVar] = callAction(arguments.actionName,arguments.args))</th>
	</tr>
	<tr valign="top">
		<th>Argument</th>
		<th>Type</th>
		<th>Required?</th>
		<th>Description</th>
	</tr>
	<tr valign="top">
		<td>requestVar</td>
		<td>string</td>
		<td>Required</td>
		<td>
			The request variable name to save the action to. e.g. requestVar = "saveit" would create a variable called request.saveit from the callAction() call.</td>
	</tr>

	<tr valign="top">
		<td>actionName</td>
		<td>string</td>
		<td>Required</td>
		<td>
			The name of the action you want to call.<br /><br />
			In multiple controllers or assigned classes:<br />
			className + actionDelimiter (0.4.4) + methodName<br />
			e.g. actionName=&quot;home.welcome&quot; is a valid value here.</td>
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
