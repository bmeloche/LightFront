<cfcomponent displayname="employee" hint="I am the employee service.">

	<!--- For basic dependency injection, LightFront doesn't need ColdSpring. True is default. It's just here to illustrate. --->
	<cfset employeeGateway = application.lfront.initComponent("employeeGateway",true) />
	<cfset employeeDAO = application.lfront.initComponent("employeeDAO",true) />

	<cffunction name="getEmployeesAsQuery" access="public" returntype="query" hint="I get the employees.">
		<cfreturn employeeGateway.makeFakeEmployeeQueryData() />
	</cffunction>

	<cffunction name="getEmployeesAsArray" access="public" returntype="array" hint="I get the employees as an array.">
		<cfreturn queryToArrayOfStructures(employeeGateway.makeFakeEmployeeQueryData()) />
	</cffunction>

	<cffunction name="getEmployees" access="public" returntype="array" hint="I get the employees as an array of objects.">
		<cfset var qList = getEmployeesAsArray() />
		<cfreturn makeArrays(qList) />
	</cffunction>

	<cffunction name="getEmployee" access="public" returntype="array" output="true" hint="I get the employee as an array of objects.">
		<cfargument name="employeeID" type="uuid" required="true">
		<cfset var qList = queryToArrayOfStructures(employeeGateway.getByAttributesQuery(arguments.employeeID)) />
		<cfset request.foo = qList>
		<cfreturn makeArrays(qList) />
	</cffunction>

	<cffunction name="makeArrays" access="public" returntype="array" hint="I get an array of employees and return an array of objects.">
		<cfargument name="tmpArray" type="array" />
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#arrayLen(arguments.tmpArray)#" index="i">
			<cfset tmpObj = createObject("component","employee").init(argumentCollection=arguments.tmpArray[i]) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
		<cfreturn arrObjects />
	</cffunction>

	<cfscript>
		/**
		* Converts a query object into an array of structures.
		*
		* @param query      The query to be transformed
		* @return This function returns a structure.
		* @author Nathan Dintenfass (nathan@changemedia.com)
		* @version 1, September 27, 2001
		*/
		function QueryToArrayOfStructures(theQuery){
			var theArray = arraynew(1);
			var cols = ListtoArray(theQuery.columnlist);
			var row = 1;
			var thisRow = "";
			var col = 1;
			for(row = 1; row LTE theQuery.recordcount; row = row + 1){
				thisRow = structnew();
				for(col = 1; col LTE arraylen(cols); col = col + 1){
					thisRow[cols[col]] = theQuery[cols[col]][row];
				}
				arrayAppend(theArray,duplicate(thisRow));
			}
			return(theArray);
		}
	</cfscript>

</cfcomponent>