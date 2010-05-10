<cfcomponent displayname="securityService" extends="lfront.lightfront" output="false" hint="Security Service">

	<cffunction name="setUserService" returntype="Any">
		<cfset variables.userService = initService("user.user") />
	</cffunction>

	<cffunction name="getUserService" returntype="Any">
		<cfif NOT structKeyExists(variables,"userService")>
			<cfset setUserService() />
		</cfif>
		<cfreturn variables.userService />
	</cffunction>

	<cffunction name="doLogin" returntype="boolean">
		<cfargument name="username" type="String" required="true" />
		<cfargument name="password" type="String" required="true" />
		<cfset var retBool = true />
		<cfset var result = getUserService().getUserByUsernamePassword(username=arguments.username,userPass=arguments.password) />
		<cfif arrayLen(result) EQ 1>
			<cfcookie name="username" value="#arguments.username#" />
		<cfelse>
			<cfset retBool = false />
		</cfif>
		<cfreturn retBool />
	</cffunction>

	<cffunction name="doLogout" returntype="void">
		<cfset structDelete(cookie,"username") />
	</cffunction>

	<cffunction name="checkCredentials" returntype="boolean">
		<cfargument name="userType" type="Numeric" required="false" />
		<!--- TODO: Stubbed credential check. --->
		<cfreturn true />
	</cffunction>

</cfcomponent>