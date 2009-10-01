<form action="./?do=doLogin" method="post">
	<h2>Login</h2>
	<cfif structKeyExists(request.attributes,"loginfailure") AND request.attributes.loginfailure>
		<h3>Your login failed! Please try again.</h3>
	<cfelseif structKeyExists(cookie,"username")>
		<h4>If you're logged in and got here, that's because you came here from do=security.login, not do=login.</h4>
	</cfif>
	<fieldset>
		<table>
			<tr>
				<td colspan="2"><p>Put anything for the username. Password=password.</p></td>
			</tr>
			<tr>
				<td>Username: </td>
				<td><input name="username" type="text"></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input name="password" type="text"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input name="login" type="submit" value="Login" /></td>
			</tr>
		</table>
	</fieldset>
</form>