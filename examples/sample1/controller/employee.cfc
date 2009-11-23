<cfcomponent displayname="employee" extends="org.lightfront.lightfront" hint="I am the employee controller.">

	<cfset employeeService = initService("employee") />

	<cffunction name="getEmployee">
		<cfreturn employeeService.getEmployee("9FD20E1E-F1B1-4746-3B1047CA188174A2") />
	</cffunction>

	<cffunction name="objects">
		<cfset var employee = employeeService.getEmployees() />
		<cfreturn displayView("employee/objects",employee) />
	</cffunction>

	<cffunction name="query">
		<cfset var employee = employeeService.getEmployeesAsQuery() />
		<cfreturn displayView("employee/query",employee) />
	</cffunction>

	<cffunction name="array">
		<cfset var employee = employeeService.getEmployeesAsArray() />
		<cfreturn displayView("employee/array",employee) />
	</cffunction>

	<cffunction name="overview">
		<cfreturn displayView("employee/overview") />
	</cffunction>

</cfcomponent>

