<cfcomponent displayname="home" extends="lightfront" output="false" hint="home controller">

	<cffunction name="init" returntype="string" output="true">
		<cfreturn welcome() />
	</cffunction>

	<cffunction name="welcome" returntype="string" output="true">
		<cfargument name="args" type="struct" required="false" />
		<cfset var loc = "" />
		<cfsavecontent variable="loc">
			<cfoutput>
				<cfif isDefined("arguments.args") AND structKeyExists(arguments.args,"loc")>
					#arguments.args.loc#
				<cfelse>
					<h2>Welcome!</h2>
				</cfif>
			</cfoutput>
		</cfsavecontent>
		<cfreturn displayView("welcome",loc) />
	</cffunction>

	<cffunction name="hello" returntype="string" output="true">
		<cfargument name="args" type="struct" required="false" />
		<cfscript>
			var local = structNew();
			if (structKeyExists(arguments,"args") AND structKeyExists(arguments.args,"username")) {
				local.username = arguments.args.username;
			} else {
				local.username = "your name";
			}
			local.loc = displayView("hello/hellothere") & callEvent("employee.getEmployee",local);
		</cfscript>
		<cfreturn local.loc />
	</cffunction>

	<cffunction name="hellovariant" returntype="string" output="true">
		<cfargument name="args" type="struct" required="false" />
		<cfscript>
			var local = structNew();
			if (structKeyExists(arguments,"args") AND structKeyExists(arguments.args,"name")) {
				local.name = arguments.args.name;
			} else {
				local.name = "your name";
			}
			local.loc = displayView("hello.hellothere") & callEvent("employee.getEmployee",local);
			return local.loc;
		</cfscript>
	</cffunction>

	<cffunction name="helloanon" returntype="string" output="true">
		<cfset var local = structNew() />
		<cfset local.loc = "<h1>Hello! I come from home.cfc helloanon!</h1>" & callEvent("employee.getEmployee") />
		<cfset local.loc = callEvent("home.welcome",local) />
		<cfreturn local.loc />
	</cffunction>

	<cffunction name="admin_home" returntype="string" output="true" hint="I display a reassigned event.">
		<cfset var local = structNew() />
		<cfset local.loc = "<h1>Hello! I come from home.cfc admin_home()! I used to be admin.home but I was reassigned!</h1>" & callEvent("employee.getEmployee") />
		<cfset local.loc = callEvent("home.welcome",local) />
		<cfreturn local.loc />
	</cffunction>

	<cffunction name="header" returntype="string" output="false">
		<cfreturn displayView("layout.header") />
	</cffunction>

	<cffunction name="footer" returntype="string" output="false">
		<cfreturn displayView("layout.footer") />
	</cffunction>

	<cffunction name="login" returntype="string" output="false">
		<cfset doLogout() />
		<cfreturn displayView("security.login") />
	</cffunction>

	<cffunction name="loginfailure" returntype="string" output="false">
		<cfset request.attributes.loginfailure = true />
		<cfreturn displayView("security.login") />
	</cffunction>

	<cffunction name="logout" returntype="string" output="false">
		<cfset doLogout() />
		<cfreturn relocate("home.welcome") />
	</cffunction>

	<cffunction name="doLogout" returntype="void" output="false">
		<cfcookie name="username" expires="-1" />
	</cffunction>

	<cffunction name="doLogin" returntype="string" output="false">
		<cfset var local = structNew() />
		<cfif (NOT structKeyExists(request.attributes,"password")) OR (structKeyExists(request.attributes,"password") AND request.attributes.password NEQ "password")>
			<cfreturn relocate("home.loginfailure") />
		<cfelseif structKeyExists(request.attributes,"password")>
			<cfcookie name="username" value="#request.attributes.username#" />
			<cfreturn relocate("home.welcome") />
		</cfif>
	</cffunction>

</cfcomponent>
