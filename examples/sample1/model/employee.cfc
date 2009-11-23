<cfcomponent displayname="employee" hint="I am the employee object.">

	<!--- This needs CF9 to work. --->
	<cfproperty name="employeeID" type="uuid" default="" />
	<cfproperty name="userID" type="numeric" default="" />
	<cfproperty name="firstname" type="string" default="" />
	<cfproperty name="lastname" type="string" default="" />
	<cfproperty name="location" type="string" default="" />
	<cfproperty name="title" type="string" default="" />

	<cfset variables.instance = structNew() />

	<cffunction name="init" access="public" returntype="employee" output="false">
		<cfargument name="employeeID" type="string" default="" />
		<cfargument name="userID" type="numeric" default="" />
		<cfargument name="firstname" type="string" default="" />
		<cfargument name="lastname" type="string" default="" />
		<cfargument name="location" type="string" default="" />
		<cfargument name="title" type="string" default="" />
		<!--- Run the accessors --->
		<cfset setEmployeeID(arguments.employeeID) />
		<cfset setUserID(arguments.userID) />
		<cfset setFirstName(arguments.firstname) />
		<cfset setLastName(arguments.lastname) />
		<cfset setLocation(arguments.location) />
		<cfset setTitle(arguments.title) />
		<cfreturn this />
	</cffunction>

	<!--- ACCESSORS - Not needed for CF9. --->

	<cffunction name="setEmployeeID" access="public" returntype="void" output="false">
		<cfargument name="employeeID" type="string" required="true" />
		<cfset variables.instance.employeeID = arguments.employeeID />
	</cffunction>
	<cffunction name="getEmployeeID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.employeeID />
	</cffunction>

	<cffunction name="setUserID" access="public" returntype="void" output="false">
		<cfargument name="userID" type="string" required="true" />
		<cfset variables.instance.userID = arguments.userID />
	</cffunction>
	<cffunction name="getUserID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.userID />
	</cffunction>

	<cffunction name="setFirstName" access="public" returntype="void" output="false">
		<cfargument name="firstName" type="string" required="true" />
		<cfset variables.instance.firstName = arguments.firstName />
	</cffunction>
	<cffunction name="getFirstName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.firstName />
	</cffunction>

	<cffunction name="setLastName" access="public" returntype="void" output="false">
		<cfargument name="lastName" type="string" required="true" />
		<cfset variables.instance.lastName = arguments.lastName />
	</cffunction>
	<cffunction name="getLastName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.lastName />
	</cffunction>

	<cffunction name="setLocation" access="public" returntype="void" output="false">
		<cfargument name="location" type="string" required="true" />
		<cfset variables.instance.location = arguments.location />
	</cffunction>
	<cffunction name="getLocation" access="public" returntype="string" output="false">
		<cfreturn variables.instance.location />
	</cffunction>

	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.title />
	</cffunction>

</cfcomponent>