<form action="./?do=security.doLogin" method="post">
	<h2>Login</h2>
	<cfif structKeyExists(request.attributes,"loginfailure") AND request.attributes.loginfailure>
		<h3 class="failure_message">Your login failed! Please try again.</h3>
	<cfelseif structKeyExists(cookie,"username")>
		<h3>If you're logged in and got here, that's because you came here from do=security.login, not do=home.login.</h3>
	</cfif>
	<fieldset title="Login Form">
		<legend> Login Form </legend>
		<table>
			<tr>
				<td colspan="2"><h3>Please login...</h3></td>
			</tr>
			<tr>
				<td><label for="name" title="username">Username:</label></td>
				<td><input name="username" type="text" id="name" /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input name="password" type="password" /></td>
			</tr>
			<tr>
				<td><label for="Submit">Login:</label></td>
				<td><input name="login" type="submit" value="Please Login" accesskey="l" id="Submit" /></td>
			</tr>
		</table>
	</fieldset>
</form>