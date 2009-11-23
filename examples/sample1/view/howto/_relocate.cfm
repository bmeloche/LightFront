<h2>relocate()</h2>
<p>relocate() is a replacement for &lt;cflocation&gt; to do a location.href redirect and keep the user in the framework.</p>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="4">relocate()</th>
	</tr>
	<tr valign="top">
		<th>Argument</th>
		<th>Type</th>
		<th>Required?</th>
		<th>Description</th>
	</tr>
	<tr valign="top">
		<td>event</td>
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
		<td>qstring</td>
		<td>string</td>
		<td>Optional</td>
		<td>
			The query string you want to pass into the relocate() request.
		</td>
	</tr>
</table>