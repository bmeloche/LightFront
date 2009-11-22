<cfcomponent displayname="main" hint="I am the skeleton controller." extends="org.lightfront.lightfront" output="false">

	<cfset directoryService = initService("directory") />
	<cffunction name="home">
		<cfset var sampleApplications = directoryService.getSampleApplications(expandPath("..")) />
		<cfreturn displayView("main/home",sampleApplications) />
	</cffunction>

</cfcomponent>