<cfcomponent displayname="securityService" output="false">

	
	<!---<cfset userService = application.lfront.service.userService />--->
	<cfset userService = createObject("component","lf.model.user.userService") />

	<cffunction name="doLogin" returntype="boolean">
		<cfargument name="username" type="String" required="true" />
		<cfargument name="password" type="String" required="true" />
		<cfset var retBool = true />
		<cfset var result = userService.getUserByUsernamePassword(username=username,userPass=password) />
		<cfif arrayLen(result) EQ 1>
			<cfcookie name="username" value="#arguments.username#" />
		<cfelse>
			<cfset retBool = false />
		</cfif>
		<cfreturn retBool />
	</cffunction>

	<cffunction name="doLogout" returntype="void">
		<!---<cfcookie name="username" expires="-1" />--->
		<cfset structDelete(cookie,"username") />
	</cffunction>

</cfcomponent>