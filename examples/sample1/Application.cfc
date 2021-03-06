<!---
	LightFront Framework - Copyright Brian Meloche 2009.
	Sample1 Application: Shows the basics for different kinds of LightFront events. This sample is stripped down, showing only what is needed to make this
	application work.
	File: Application.cfc
	Description: Now that there's a skeleton, this Application.cfc has been stripped down to show only what's necessary to make the application work.
--->
<cfcomponent displayname="Application" extends="lightfront" output="false" hint="I am the Application CFC. I am tied to Lightfront.">
	<cfscript>
		this.name = "lightfront_" & hash(getCurrentTemplatePath()) & hash(cgi.script_name);
		this.applicationTimeout = createTimeSpan(2,0,0,0);
		this.sessionManagement = true;
		this.sessionTimeout = createTimeSpan(0,0,30,0);
		this.cookieManagement = true;
		this.setClientCookies = false;
		this.mappings["/lfront"] = expandPath(".");
	</cfscript>

	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="onApplicationStart" returntype="void" access="public" output="false" hint="I start the application.">
		<cfset structClear(application) />
		<cfset this.lfrontLoadTime = getTickCount() />
		<cfset application.lfront = structNew() />
		<cfset application.lfront.settings = loadSettings(setCustomLightFrontSettings()) />
		<cfset application.lfront.initComponent = initComponent />
		<cfset application.lfront.initService = initService />
		<cfset application.lfront.ctrl = loadControllers() />
		<cfset application.startTime = now() />
		<cfset this.lfrontLoadTime = getTickCount() - this.lfrontLoadTime />
	</cffunction>

	<cffunction name="onApplicationEnd" returntype="void" access="public" output="false" hint="I end the application.">
		<cfargument name="applicationScope" type="struct" required="true" />
	</cffunction>

	<cffunction name="onSessionStart" returnType="void" access="public" output="false" hint="I start the session.">
	</cffunction>

	<cffunction name="onSessionEnd" returnType="void" access="public" output="false" hint="I end the session.">
		<cfargument name="sessionScope" type="struct" required="true" />
		<cfargument name="applicationScope" type="struct" required="false" />
	</cffunction>

	<cffunction name="onRequestStart" returntype="boolean" access="public" output="true" hint="I run before any non-remote calls.">
		<cfargument name="targetPage" type="string" required="true" />
		<cfset request.attributes = structNew() />
		<cfset request.actionResult = "" />
		<!--- Check to see if a reinit has been requested. --->
		<cfif structKeyExists(url,application.lfront.settings.reload) AND url[application.lfront.settings.reload] EQ application.lfront.settings.reloadPassword>
			<cfset onApplicationStart() />
		</cfif>
		<!--- Add anything you see fit here. --->
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequest" output="true">
		<cfargument name="targetPage" type="string" required="true" />
		<cfif isLightfront(arguments.targetPage)>
			<cfset loadRequest() />
		<cfelse>
			<!--- Add any alternate types of requests here, if needed that will not follow Lightfront conventions. --->
		</cfif>
	</cffunction>

	<cffunction name="onRequestEnd" returntype="void" output="true" hint="I run at the end of the request.">
		<cfif structKeyExists(request,"actionResult")>
			<cfset writeOutput(request.actionResult) />
		</cfif>
		<cfif structKeyExists(this,"lfrontLoadTime")>
			<cfoutput>LightFront was reloaded in #this.lfrontLoadTime# ms #dateFormat(application.startTime)# #timeFormat(application.startTime)#</cfoutput>
		</cfif>
		<cfif allowDump()>
			<cfoutput>LightFront Framework - Scope Dump</cfoutput>
			<cfdump var="#cgi#" expand="false" label="CGI scope">
			<cfdump var="#request#" expand="false" label="Request scope">
			<cfdump var="#variables#" expand="false" label="Variables scope">
			<cfdump var="#application#" expand="false" label="Application scope">
		</cfif>
	</cffunction>

	<!--- PRIVATE FUNCTIONS --->
	<cffunction name="isLightfront" access="private" returntype="boolean" hint="Logic to prove this is NOT a LightFront request. You would do this if you are using index.cfm for another purpose.">
		<cfargument name="targetPage" type="string" required="true" />
		<cfset var retBool = true />
		<cfreturn retBool />
	</cffunction>
	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		<cfdump var="#arguments#"><cfabort>
	</cffunction>

	<cffunction name="allowDump" access="private" returntype="boolean" hint="Logic to check to see if a dump is allowed or not for this request.">
		<cfreturn (structKeyExists(request.attributes,"dump") AND structKeyExists(application.lfront.settings,"dump") AND structKeyExists(application.lfront.settings.dump,"allow") AND application.lfront.settings.dump.allow EQ true AND structKeyExists(application.lfront.settings.dump,"password") AND request.attributes.dump EQ application.lfront.settings.dump.password) />
	</cffunction>

	<cffunction name="setCustomLightFrontSettings" access="private" returntype="struct" hint="I set LightFront application settings.">
		<cfscript>
			var settings = structNew();
			/* applicationMode: The mode of your application. You should always specify this setting in your Application.cfc!
			*  Allowed values:
			*	development-reload = The application restarts on each request. Dump is always provided. Recommended if you're constantly updating the application.
			*	development = The application restarts only when a reload is requested. Dump is always provided. This is the default setting.
			*	testing = The application restarts only when a reload is requested. Dump is provided when a dump is requested. Recommended setting for large applications in development or testing.
			*	production = Application restarts and dumps are only provided on the server or by specific IP subset. Restricted mode for security purposes.*/
			settings.applicationMode = "testing"; //You can reload and get dumps, but they are not automatically provided.
			settings.defaultController = "home";
			settings.defaultAction = "welcome";
			settings.preAction = "layout.header";
			settings.postAction = "layout.footer";
			settings.serviceSuffix = "Service";
			settings.switch = structNew();
			settings.switch.switchVariable = "fuseaction"; //this will assign do to fuseaction.
			settings.switch.switchPage = "switch.cfm"; //the name of the switch file. This might be called fbx_switch.cfm if you are porting over a Fusebox app.
			settings.switch.switchDirectory = "/lfront/controller/switch/";
			settings.switch.switches = structNew();
			settings.switch.switches.switch = "";
			settings.switch.switches.test = "test/";
			return settings;
		</cfscript>
	</cffunction>

</cfcomponent>