<cfcomponent displayname="main" extends="org.lightfront.lightfront" output="false" hint="home controller">

	<cfset securityService = application.lfront.service.securityService.init() />
	<cfset categoryService = application.lfront.service.categoryService.init() />

	<cffunction name="onMissingMethod" returntype="string" output="false">
		<cfargument name="missingMethodName" type="string" required="true" hint="The name of the missing method." />
		<cfargument name="missingMethodArguments" type="struct" required="false" hint="The arguments that were passed to the missing method. This might be a named argument set or a numerically indexed set." />
		<cfreturn displayView("main/#arguments.missingMethodName#") />
	</cffunction>

	<!---<cffunction name="default" returntype="string" output="false">
		<cfreturn displayView("main/default") />
	</cffunction>

	<cffunction name="about" returntype="string" output="false">
		<cfreturn displayView("main/about") />
	</cffunction>

	<cffunction name="staff" returntype="string" output="false">
		<cfreturn displayView("main/staff") />
	</cffunction>

	<cffunction name="contact" returntype="string" output="false">
		<cfreturn displayView("main/contact") />
	</cffunction>--->

	<!--- Security --->
	<cffunction name="login" returntype="string" output="false">
		<!--- logout the person if they are logged in. You can also just do logout() here. --->
		<cfreturn doLogout() />
	</cffunction>

	<cffunction name="logout" returntype="string" output="false">
		<cfreturn doLogout() />
	</cffunction>


	<cffunction name="showLogin" returntype="String" output="false">
		<cfreturn displayView("security.login") />
	</cffunction>

	<cffunction name="doLogin" returntype="string" output="false">
		<cfargument name="username" required="true" type="String" default="" />
		<cfargument name="password" required="true" type="String" default="" />
		<cfset var loc = structNew() />
		<cfif structKeyExists(request.attributes,"username")>
			<cfset arguments.username = request.attributes.username />
		</cfif>
		<cfif structKeyExists(request.attributes,"password")>
			<cfset arguments.password = request.attributes.password />
		</cfif>
		<!--- Call the security service to attempt a login. Returns a true/false. --->
		<cfset loc.result = securityService.doLogin(argumentCollection=arguments) />
		<cfif loc.result>
			<cfreturn relocate("admin.welcome") />
		<cfelse>
			<cfreturn relocate("security.showlogin","loginfailure=1") />
		</cfif>
	</cffunction>

	<cffunction name="doLogout" returntype="string" output="false">
		<!--- Call the security service to logout. --->
		<cfset securityService.doLogout() />
		<cfreturn relocate("security.showLogin") />
	</cffunction>

	<!--- Admin --->
	<cffunction name="welcome" returntype="string" output="false">
		<cfreturn displayView("admin/welcome") />
	</cffunction>

	<cffunction name="categories" returntype="string" output="false">
		<cfset var local = structNew() />
		<cfset local.categoryList = categoryService.getAllCategory() />
		<cfreturn displayView("admin/categories",local) />
	</cffunction>

	<cffunction name="editCategory" returntype="string" output="false">
		<cfargument name="id" type="Numeric" default="0" />
		<cfset var local = structNew() />
		<cfset local.category = queryNew("id,categoryName","integer,varchar") />
		<cfif structKeyExists(request.attributes,"id")>
			<cfset arguments.id = request.attributes.id />
		</cfif>
		<cfif arguments.id NEQ 0>
			<cfset local.category = categoryService.getCategory(ID=arguments.id) />
		</cfif>
		<cfreturn displayView("admin/editcategory",local) />
	</cffunction>

</cfcomponent>