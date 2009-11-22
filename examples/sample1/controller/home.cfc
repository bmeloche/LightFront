<cfcomponent displayname="home" extends="org.lightfront.lightfront" output="false" hint="home controller">

	<cfset securityService = initService("security") />

	<cffunction name="init" returntype="string" output="true">
		<cfreturn welcome() />
	</cffunction>

	<cffunction name="welcome" returntype="string" output="true">
		<cfargument name="args" type="struct" required="false" />
		<cfset var lfront = "" />
		<cfif isDefined("arguments.args") AND structKeyExists(arguments.args,"lfront")>
			<cfset lfront = arguments.args.lfront />
		</cfif>
		<cfreturn displayView("home.welcome",lfront) />
	</cffunction>

	<cffunction name="employee" returntype="string" output="true">
		<cfargument name="args" type="struct" required="false" />
		<cfscript>
			var lfront = structNew();
			if (structKeyExists(arguments,"args") AND structKeyExists(arguments.args,"username")) {
				lfront.username = arguments.args.username;
			} else {
				lfront.username = "";
			}
			lfront.loc = displayView("hello/hellothere") & callEvent("employee.getEmployee",lfront);
		</cfscript>
		<cfreturn lfront.loc />
	</cffunction>

	<cffunction name="hellovariant" returntype="string" output="true">
		<cfargument name="args" type="struct" required="false" />
		<cfscript>
			var lfront = structNew();
			if (structKeyExists(arguments,"args") AND structKeyExists(arguments.args,"username")) {
				lfront.username = arguments.args.username;
			} else {
				lfront.username = "";
			}
			lfront.employeeInfo = callEvent("employee.getEmployee",lfront);
			return displayView("hello.hellothere",lfront);
		</cfscript>
	</cffunction>

	<cffunction name="helloanon" returntype="string" output="true">
		<cfset var lfront = structNew() />
		<cfset lfront.loc = "<h1>Hello! I come from home.cfc helloanon!</h1>" & callEvent("employee.getEmployee") />
		<cfset lfront.loc = callEvent("home.welcome",lfront.loc) />
		<cfreturn lfront.loc />
	</cffunction>

	<cffunction name="admin_home" hint="I display a reassigned event.">
		<cfset var lfront = structNew() />
		<cfset lfront.loc = "<h1>Hello! I come from home.cfc admin_home()! I used to be admin.home but I was reassigned!</h1>" & callEvent("employee.getEmployee") />
		<cfset lfront.loc = callEvent("home.welcome",lfront) />
		<cfreturn lfront.loc />
	</cffunction>

	<cffunction name="header">
		<cfreturn displayView("layout.header") />
	</cffunction>

	<cffunction name="footer">
		<cfreturn displayView("layout.footer") />
	</cffunction>

	<cffunction name="login">
		<cfset securityService.doLogout() />
		<cfreturn displayView("security.login") />
	</cffunction>

	<cffunction name="loginfailure">
		<cfset var loginfailure = true />
		<cfreturn displayView("security.login") />
	</cffunction>

	<cffunction name="logout">
		<cfset securityService.doLogout() />
		<cfreturn relocate("home.welcome") />
	</cffunction>

	<cffunction name="doLogin">
		<cfargument name="args" type="struct" required="true" />
		<cfset var login = false />
		<cfif structKeyExists(arguments,"args") and structKeyExists(arguments.args,"username") AND structKeyExists(arguments.args,"password")>
			<cfset login = securityService.doLogin(arguments.args.username,arguments.args.password) />
		</cfif>
		<cfif login>
			<cfreturn relocate("home.welcome") />
		<cfelse>
			<cfreturn relocate("home.loginfailure") />
		</cfif>
	</cffunction>

</cfcomponent>
