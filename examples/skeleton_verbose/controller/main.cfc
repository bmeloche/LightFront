<cfcomponent displayname="main" hint="I am the skeleton controller." extends="lfront.lightfront" output="false">

	<cfset directoryService = initService("directory") />
	<cffunction name="home">
		<cfset var sampleApplications = directoryService.getSampleApplications(expandPath("..")) />
		<cfreturn displayView("main/home",sampleApplications) />
	</cffunction>

</cfcomponent>