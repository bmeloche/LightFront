<cfcomponent displayname="Application" extends="lightfront" output="false" hint="I am the Application CFC. I am tied to Lightfront.">
	<cfscript>
		//Set the application properties. Customize to meet your needs.
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
	<cffunction name="isLightFront" access="private" returntype="boolean" hint="Logic to prove this is NOT a LightFront request. You would do this if you are using index.cfm for another purpose.">
		<cfargument name="targetPage" type="string" required="true" />
		<cfset var retBool = true />
		<cfreturn retBool />
	</cffunction>

	<cffunction name="allowDump" access="private" returntype="boolean" hint="Logic to check to see if a dump is allowed or not for this request.">
		<cfreturn (structKeyExists(request.attributes,"dump") AND structKeyExists(application.lfront.settings,"dump") AND structKeyExists(application.lfront.settings.dump,"allow") AND application.lfront.settings.dump.allow EQ true AND structKeyExists(application.lfront.settings.dump,"password") AND request.attributes.dump EQ application.lfront.settings.dump.password) />
	</cffunction>

	<cffunction name="setCustomLightFrontSettings" access="private" returntype="struct" hint="I set custom LightFront application settings.">
		<cfscript>
			var lfront = structNew();
			//Add your custom settings here.
			return lfront;
		</cfscript>
	</cffunction>

</cfcomponent>