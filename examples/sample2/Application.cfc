<cfcomponent displayname="Application" extends="org.lightfront.lightfront" output="false" hint="I am the Application CFC. I am tied to Lightfront.">
	<cfscript>
		//Set the application properties. Customize to meet your needs.
		this.name = "lightfront_" & hash(getCurrentTemplatePath()) & hash(cgi.script_name);
		this.applicationTimeout = createTimeSpan(2,0,0,0);
		this.sessionManagement = true;
		this.sessionTimeout = createTimeSpan(0,0,30,0);
		this.cookieManagement = true;
		this.setClientCookies = false;
		this.datasource = "aeqDSN";
		this.ormenabled = true;
		this.ormsettings = {
			cfclocation = "model"
		};
		//if this is a development server...
		this.developmentServer = true;
		if(this.developmentServer) {
			this.ormsettings.dbcreate = "dropcreate";
			this.ormsettings.logSQL = true;
			this.ormsettings.autorebuild = true;
		}
		/*The "lf" mapping is designed to make LightFront work at both the root of your applications as well as in a subdirectory.
		* It's used to find your controllers and views inside LightFront itself.*/
		this.mappings["/lf"] = expandPath(".");
		/*If you have your controller and view folders are outside of your LightFront application folder (this folder), you will need to
		* add mappings to lf/controller and lf/view (match the cfcControllerDirectory and viewDirectory setting name.)*/
		//this.mappings["/lf/model"] = expandPath("./model");
		//this.mappings["/lf/controller"] = expandPath("./controller");
		//this.mappings["/lf/view"] = expandPath("./view");
	</cfscript>

	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="onApplicationStart" returntype="void" access="public" output="false" hint="I start the application.">
		<cfset var local = structNew() />
		<cfset structClear(application) />
		<!--- If you need to load anything in the Application scope prior to starting LightFront, load it here. --->
		<cfset this.lfLoadTime = getTickCount() />
		<cfset application.thiswas = this />
		<cfset application.lfront = structNew() />
		<cfset application.lfront.settings = loadSettings(setCustomLightFrontSettings()) />
		<cfset application.lfront.service = loadServices() />
		<cfset application.lfront.ctrl = loadControllers() />
		<!---<cfset application.lfront.ctrl = local.cfcs.controllers />--->
		<cfset application.startTime = now() />
		<cfset this.lfLoadTime = getTickCount() - this.lfLoadTime />
		<!--- If you need to set anything in the Application scope after starting Lightfront, set it here. --->
	</cffunction>

	<cffunction name="onApplicationEnd" returntype="void" access="public" output="false" hint="I end the application.">
		<cfargument name="applicationScope" type="struct" required="true" />
		<!--- Add anything you see fit here. --->
	</cffunction>

	<cffunction name="onSessionStart" returnType="void" access="public" output="false" hint="I start the session.">
		<!--- Add anything you see fit here. --->
	</cffunction>

	<cffunction name="onSessionEnd" returnType="void" access="public" output="false" hint="I end the session.">
		<cfargument name="sessionScope" type="struct" required="true" />
		<cfargument name="applicationScope" type="struct" required="false" />
		<!--- Add anything you see fit here. --->
	</cffunction>

	<cffunction name="onRequestStart" returntype="boolean" access="public" output="true" hint="I run before any non-remote calls.">
		<cfargument name="targetPage" type="string" required="true" />
		<cfset var loc = structNew() />
		<cfset request.attributes = structNew() />
		<cfset request.eventResult = "" />
		<!--- Check to see if a reinit has been requested. --->
		<cfif structKeyExists(url,application.lfront.settings.reload) AND url[application.lfront.settings.reload] EQ application.lfront.settings.reloadPassword>
			<cfset onApplicationStart() />
		</cfif>
		<cfif isLightfront(arguments.targetPage)>
			<!--- Call Lightfront to initiate the request. --->
			<cfset loadLightFrontRequest() />
		<cfelse>
			<!--- Add any alternate types of requests here, if needed that will not follow Lightfront conventions. --->
		</cfif>
		<!--- Add anything you see fit here. --->
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequest" output="true">
		<cfargument name="targetPage" type="string" required="true" />
		<cfcontent reset="true" />
	</cffunction>

	<cffunction name="onRequestEnd" returntype="void" output="true" hint="I run at the end of the request.">
		<cfif structKeyExists(request,"final")>
			<cfset writeOutput(request.final) />
		</cfif>
		<cfif structKeyExists(this,"lfLoadTime")>
			<cfoutput>LightFront was reloaded in #this.lfLoadTime# ms #dateFormat(application.startTime)# #timeFormat(application.startTime)#</cfoutput>
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
		<!--- Customize here - Add additional logic to prove/disprove this is a Lightfront request. --->
		<!--- The following lines are listed as an example.
		<cfif application.lfront.settings.allowNonDefaultPages IS false AND compareNoCase(application.lfront.settings.defaultPage,listLast(arguments.targetPage,'.')) IS false>
			<cfset retBool = false />
		</cfif> --->
		<cfreturn retBool />
	</cffunction>

	<cffunction name="allowDump" access="private" returntype="boolean" hint="Logic to check to see if a dump is allowed or not for this request.">
		<cfreturn (structKeyExists(request.attributes,"dump") AND structKeyExists(application.lfront.settings,"dump") AND structKeyExists(application.lfront.settings.dump,"allow") AND application.lfront.settings.dump.allow EQ true AND structKeyExists(application.lfront.settings.dump,"password") AND request.attributes.dump EQ application.lfront.settings.dump.password) />
	</cffunction>

	<cffunction name="setCustomLightFrontSettings" access="private" returntype="struct" hint="I set LightFront application settings.">
		<cfscript>
			var lfs = structNew();
			lfs.postEvent = "layout.main";
			lfs.postEventRequest = "final";
			lfs.assignments = structNew();
			lfs.assignments.security = "main";
			lfs.assignments.admin = "main";
			return lfs;
		</cfscript>
	</cffunction>

</cfcomponent>