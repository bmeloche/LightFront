<cfcomponent displayname="directory" hint="I am a simple directory service, to demonstrate how LightFront interacts with the model. This CFC acts as the data layer, too.">

	<cffunction name="getSampleApplications" returntype="query" hint="I read the sample directory for other applications.">
		<cfargument name="directoryPath" type="string" required="true" />
		<cfset var directoryScan = "" />
		<cfdirectory action="list" directory="#arguments.directoryPath#" name="directoryScan" />
		<cfquery name="directoryScan" dbtype="query">
			SELECT * FROM directoryScan
			WHERE NAME <> '.svn'
		</cfquery>
		<cfreturn directoryScan />
	</cffunction>

</cfcomponent>