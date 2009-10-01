<h2>What is callEvent()?</h2>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="3">callEvent()</th>
	</tr>
	<tr valign="top">
		<th>Argument</th>
		<th>Type</th>
		<th>Required?</th>
		<th>Description</th>
	</tr>
	<tr valign="top">
		<td>eventName</td>
		<td>string</td>
		<td>Required</td>
		<td>
			The name of the event you want to call.<br /><br />
			In multiple controllers or assigned classes:<br />
			className + eventDelimiter + methodName<br />
			e.g. home.welcome
		</td>
	</tr>
	<tr valign="top">
		<td>args</td>
		<td>any</td>
		<td>Optional</td>
		<td>
			Any data you want to pass into the event (this will probably be deprecated).
		</td>
	</tr>
</table>