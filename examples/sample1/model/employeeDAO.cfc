<cfcomponent displayname="employeeDAO" hint="table ID column = employeeID">

	<!--- The sample doesn't have a DSN, but I wanted to show the functions. --->
	<cfset variables.dsn = "">

	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="employee" type="employee" required="true" />
		<cfset var qCreate = "" />
		<cftry>
			<!--- We're serving up the query in the application scope, so we are not doing a database call. We will, however, add a record to that scoped query.
			I have left the code alone, should you want to create a database with an employee table. --->
			<!--- <cfquery name="qCreate" datasource="#variables.dsn#">
				INSERT INTO employee
					(
					employeeID,
					userID,
					firstName,
					lastName,
					location,
					title
					)
				VALUES
					(
					<cfqueryparam value="#arguments.employee.getemployeeID()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.getemployeeID())#" />,
					<cfqueryparam value="#arguments.employee.getuserID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.employee.getfirstName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.getfirstName())#" />,
					<cfqueryparam value="#arguments.employee.getlastName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.getlastName())#" />,
					<cfqueryparam value="#arguments.employee.getlocation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.getlocation())#" />,
					<cfqueryparam value="#arguments.employee.gettitle()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.gettitle())#" />
					)
			</cfquery> --->
			<cfif structKeyExists(application,"employee")>
			</cfif>
			<cfcatch type="any">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="employee" type="model.employee" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					employeeID,
					userID,
					firstName,
					lastName,
					location,
					title
				FROM	employee
				WHERE	employeeID = <cfqueryparam value="#arguments.employee.getemployeeID()#" CFSQLType="cf_sql_varchar" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.employee.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="employee" type="model.employee" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	employee
				SET
					userID = <cfqueryparam value="#arguments.employee.getuserID()#" CFSQLType="cf_sql_integer" />,
					firstName = <cfqueryparam value="#arguments.employee.getfirstName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.getfirstName())#" />,
					lastName = <cfqueryparam value="#arguments.employee.getlastName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.getlastName())#" />,
					location = <cfqueryparam value="#arguments.employee.getlocation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.getlocation())#" />,
					title = <cfqueryparam value="#arguments.employee.gettitle()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.employee.gettitle())#" />
				WHERE	employeeID = <cfqueryparam value="#arguments.employee.getemployeeID()#" CFSQLType="cf_sql_varchar" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="employee" type="model.employee" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	employee
				WHERE	employeeID = <cfqueryparam value="#arguments.employee.getemployeeID()#" CFSQLType="cf_sql_varchar" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="employee" type="model.employee" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	employee
			WHERE	employeeID = <cfqueryparam value="#arguments.employee.getemployeeID()#" CFSQLType="cf_sql_varchar" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="employee" type="model.employee" required="true" />

		<cfset var success = false />
		<cfif exists(arguments.employee)>
			<cfset success = update(arguments.employee) />
		<cfelse>
			<cfset success = create(arguments.employee) />
		</cfif>

		<cfreturn success />
	</cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">

		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 *
			 * @param query 	 The query to work with.
			 * @param row 	 Row number to check. Defaults to row 1.
			 * @return Returns a structure.
			 * @author Nathan Dintenfass (nathan@changemedia.com)
			 * @version 1, December 11, 2001
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>

</cfcomponent>