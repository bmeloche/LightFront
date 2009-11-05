<form action="./?do=security.doLogin" method="post">
	<h1>Login</h1>
	<cfif structKeyExists(request.attributes,"loginfailure") AND request.attributes.loginfailure>
		<h2>Your login failed! Please try again.</h2>
	<cfelseif structKeyExists(cookie,"username")>
		<h2>If you're logged in and got here, that's because you came here from do=security.login, not do=home.login.</h2>
	</cfif>
	<fieldset title="Login Form">
		<legend> Login Form </legend>
		<table>
			<tr>
				<td colspan="2"><h3>Put anything in for the username. Password = password.</h3></td>
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