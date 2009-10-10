<cfcomponent displayname="employee" hint="The employee CFC" extends="org.lightfront.lightfront" output="true">

	<cffunction name="getEmployee" access="package" hint="I get the employee." output="true" returntype="string">
		<cfargument name="args" type="struct" required="false" />
		<cfif structKeyExists(arguments,"args") AND structKeyExists(arguments.args,"username")>
			<cfreturn "<h2>Employee 000 - " & arguments.args.username & "</h2>" />
		<cfelse>
			<cfreturn "<h2>Employee 001 - Mr. NonDescript" & "</h2>" />
		</cfif>
	</cffunction>

</cfcomponent>