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
		<cfreturn displayView("home.welcome",loc) />
	</cffunction>

	<cffunction name="hello" returntype="string" output="true">
		<cfargument name="args" type="struct" required="false" />
		<cfscript>
			var loc = structNew();
			if (structKeyExists(arguments,"args") AND structKeyExists(arguments.args,"username")) {
				loc.username = arguments.args.username;
			} else {
				loc.username = "your name";
			}
			loc.loc = displayView("hello/hellothere") & callEvent("employee.getEmployee",loc);
		</cfscript>
		<cfreturn loc.loc />
	</cffunction>

	<cffunction name="hellovariant" returntype="string" output="true">
		<cfargument name="args" type="struct" required="false" />
		<cfscript>
			var loc = structNew();
			if (structKeyExists(arguments,"args") AND structKeyExists(arguments.args,"name")) {
				loc.name = arguments.args.name;
			} else {
				loc.name = "your name";
			}
			loc.loc = displayView("hello.hellothere") & callEvent("employee.getEmployee",loc);
			return loc.loc;
		</cfscript>
	</cffunction>

	<cffunction name="helloanon" returntype="string" output="true">
		<cfset var lc = structNew() />
		<cfset lc.loc = "<h1>Hello! I come from home.cfc helloanon!</h1>" & callEvent("employee.getEmployee") />
		<cfset lc.loc = callEvent("home.welcome",lc.loc) />
		<cfreturn lc.loc />
	</cffunction>

	<cffunction name="admin_home" returntype="string" output="true" hint="I display a reassigned event.">
		<cfset var loc = structNew() />
		<cfset loc.loc = "<h1>Hello! I come from home.cfc admin_home()! I used to be admin.home but I was reassigned!</h1>" & callEvent("employee.getEmployee") />
		<cfset loc.loc = callEvent("home.welcome",loc) />
		<cfreturn loc.loc />
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
		<cfset var loc = structNew() />
		<cfif (NOT structKeyExists(request.attributes,"password")) OR (structKeyExists(request.attributes,"password") AND request.attributes.password NEQ "password")>
			<cfreturn relocate("home.loginfailure") />
		<cfelseif structKeyExists(request.attributes,"password")>
			<cfcookie name="username" value="#request.attributes.username#" />
			<cfreturn relocate("home.welcome") />
		</cfif>
	</cffunction>

</cfcomponent>
