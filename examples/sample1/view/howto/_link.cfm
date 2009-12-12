<h2>link()</h2>
<p>link() is a replacement for hard coding a link.</p>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="4">link()</th>
	</tr>
	<tr valign="top">
		<th>Argument</th>
		<th>Type</th>
		<th>Required?</th>
		<th>Description</th>
	</tr>
	<tr valign="top">
		<td>action</td>
		<td>string</td>
		<td>Required</td>
		<td>
			The name of the action you want to call.<br /><br />
			In multiple controllers or assigned classes:<br />
			className + actionDelimiter + methodName<br />
			e.g. #link('home.welcome')#
		</td>
	</tr>
	<tr valign="top">
		<td>qstring</td>
		<td>string</td>
		<td>Optional</td>
		<td>
			The query string you want to pass into the link() request.<br />
			e.g. #link('admin.find','ID=2&state=OH')#
		</td>
	</tr>
</table>