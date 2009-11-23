<cfcomponent>

	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="employeeID" type="string" required="false" />
		<cfargument name="userID" type="numeric" required="false" />
		<cfargument name="firstName" type="string" required="false" />
		<cfargument name="lastName" type="string" required="false" />
		<cfargument name="location" type="string" required="false" />
		<cfargument name="title" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = makeFakeEmployeeQueryData() />
		<cfquery name="qList" dbtype="query">
			SELECT
				employeeID,
				userID,
				firstName,
				lastName,
				location,
				title
			FROM	qList
			WHERE	0=0
		<cfif structKeyExists(arguments,"employeeID") and len(arguments.employeeID)>
			AND employeeID = <cfqueryparam value="#arguments.employeeID#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"userID") and len(arguments.userID)>
			AND userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"firstName") and len(arguments.firstName)>
			AND firstName = <cfqueryparam value="#arguments.firstName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"lastName") and len(arguments.lastName)>
			AND lastName = <cfqueryparam value="#arguments.lastName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"location") and len(arguments.location)>
			AND location = <cfqueryparam value="#arguments.location#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"title") and len(arguments.title)>
			AND title = <cfqueryparam value="#arguments.title#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		<cfreturn qList />
	</cffunction>

	<cffunction name="makeFakeEmployeeQueryData" access="public" hint="I make employees.">
		<cfset var employees = queryNew("employeeID,userID,firstName,lastName,location,title","varchar,integer,varchar,varchar,varchar,varchar") />
		<cfset var temp = "" />
		<cfset var path = replace(expandPath("./model"),"\","/","all") />
		<cfif structKeyExists(application,"employees")>
			<cfset employees = application.employees />
		<cfelse>
			<cfset queryAddRow(employees,3) />
			<cfset querySetCell(employees,"employeeID","9FD20E1E-F1B1-4746-3B1047CA188174A2",1) />
			<cfset querySetCell(employees,"userID",1,1) />
			<cfset querySetCell(employees,"firstName","Brian",1) />
			<cfset querySetCell(employees,"lastName","Meloche",1) />
			<cfset querySetCell(employees,"location","Cleveland",1) />
			<cfset querySetCell(employees,"title","LightFront Creator",1) />
			<cfset querySetCell(employees,"employeeID",createUUID(),2) />
			<cfset querySetCell(employees,"userID",2,2) />
			<cfset querySetCell(employees,"firstName","Laura",2) />
			<cfset querySetCell(employees,"lastName","Fletcher",2) />
			<cfset querySetCell(employees,"location","Toronto",2) />
			<cfset querySetCell(employees,"title","Light Technician",2) />
			<cfset querySetCell(employees,"employeeID",createUUID(),3) />
			<cfset querySetCell(employees,"userID",3,3) />
			<cfset querySetCell(employees,"firstName","Lisa",3) />
			<cfset querySetCell(employees,"lastName","Feldman",3) />
			<cfset querySetCell(employees,"location","Charleston",3) />
			<cfset querySetCell(employees,"title","Front Desk Receptionist",3) />
			<cfset application.employees = employees />
		</cfif>
		<cfwddx action="cfml2wddx" input="#application.employees#" output="temp">
		<cffile action="write" file="#path#/employee.wddx" output="#temp#">
		<cfreturn employees />
	</cffunction>

</cfcomponent>