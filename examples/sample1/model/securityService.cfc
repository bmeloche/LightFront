<cfcomponent displayname="security" hint="I am the security service.">

	<cffunction name="doLogin" returntype="boolean" hint="I attempt to login people.">
		<cfargument name="username" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		<cfset var retBool = false />
		<cfif structKeyExists(arguments,"username") AND structKeyExists(arguments,"password") AND arguments.password EQ "password">
			<cfcookie name="username" value="#arguments.username#" />
			<cfset retBool = true />
		</cfif>
		<cfreturn retBool />
	</cffunction>

	<cffunction name="doLogout" returntype="void" hint="I logout people.">
		<cfcookie name="username" expires="-1" />
	</cffunction>

</cfcomponent>