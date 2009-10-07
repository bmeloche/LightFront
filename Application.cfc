<cfcomponent displayname="Application" extends="org.lightfront.lightfront" output="false" hint="I am the Application CFC. I am tied to Lightfront.">
	<cfscript>
		//Set the application properties. Customize to meet your needs.
		this.name = "lightfront_" & hash(getCurrentTemplatePath());
		this.applicationTimeout = createTimeSpan(2,0,0,0);
		this.sessionManagement = true;
		this.sessionTimeout = createTimeSpan(0,0,30,0);
		this.cookieManagement = true;
		this.setClientCookies = false;
		this.mappings["/"] = expandPath("./");
		this.mappings["controller"] = expandPath("./controller");
		this.mappings["view"] = expandPath("./view");
	</cfscript>

	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="onApplicationStart" returntype="void" access="public" output="false" hint="I start the application.">
		<cfset structClear(application) />
		<!--- If you need to load anything in the Application scope prior to starting LightFront, load them here. --->
		<cfset this.lfLoadTime = getTickCount() />
		<cfset application.thiswas = this />
		<cfset application.lfront = structNew() />
		<cfset application.lfront.settings = loadSettings(getSettingsForLightFront()) />
		<cfset application.lfront.ctrl = loadLightFront() />
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
		<cfif structKeyExists(request,"eventResult")>
			<cfset writeOutput(request.eventResult) />
		</cfif>
		<cfif structKeyExists(this,"lfLoadTime")>
			<cfoutput>LightFront was reloaded in #this.lfLoadTime# ms #dateFormat(application.startTime)# #timeFormat(application.startTime)#</cfoutput>
		</cfif>
		<cfif structKeyExists(request.attributes,"dump")>
			<cfoutput>Scope Dump</cfoutput>
			<cfdump var="#request#" expand="false" label="Request scope">
			<cfdump var="#variables#" expand="false" label="Variables scope">
			<cfdump var="#application#" expand="false" label="Application scope">
		</cfif>
	</cffunction>

	<!--- PRIVATE FUNCTIONS --->
	<cffunction name="isLightfront" access="private" returntype="boolean" hint="Logic to prove this is NOT a LightFront request. You would do this if you are using index.cfm for another purpose.">
		<cfargument name="targetPage" type="string" required="true" />
		<cfset var retBool = true />
		<!---<cfif application.lfront.settings.allowNonDefaultPages IS false AND compareNoCase(application.lfront.settings.defaultPage,listLast(arguments.targetPage,'.')) IS false>
			<cfset retBool = false />
		</cfif>--->
		<!--- Customize here - Add additional logic to prove/disprove this is a Lightfront request. --->
		<cfreturn retBool />
	</cffunction>

	<cffunction name="getSettingsForLightFront" access="private" returntype="struct" hint="I set LightFront application settings.">
		<cfscript>
			//LightFront application settings are configured here, and are loaded in onApplicationStart().
			//These settings are accessible via the application.lfront.settings scope.
			var lfs = structNew();
			//I'm using lfs here instead of "local". In CF9, you have to be careful how you use a variable called "local".

			//1) Mandatory Settings (have no defaults)
			//These must be set in LightFront in your config file.
			lfs.defaultClass = "home"; //used if no classes are defined.
			lfs.defaultMethod = "welcome";
			lfs.reload = "reload";
			lfs.reloadpassword = "true";

			//2) Required Settings (that have defaults)
			//These settings must be set within LightFront, but they have default values. You only need to include them if you have to override the default value.
			//lfs.startupTimeout = 60; //Set the initial framework load timeout here. 60 is the default, though LightFront would not need anywhere near that.
			//lfs.eventVariable = "do"; //eg. index.cfm?do=home.welcome; "do" is the default. home.welcome is the event. home = class, welcome = method.
			//lfs.eventDelimiter = "."; //
			//lfs.modelDirectory = "/model/"; //Leaving here - possible addition to the framework. Not used in this version.
			//lfs.viewDirectory = "/view/"; //Your controller directory; /view/ is the default.
			//lfs.cfcControllerDirectory = "/controller/"; //Your controller directory; /controller/ is the default.
			//lfs.controllerPrefix = ""; //eg. prefix = "lf": class = home, controller = lfhome.cfc. "" is the default.
			//lfs.controllerSuffix = ""; //eg. suffix = "controller": class = home, controller = homecontroller.cfc. "" is the default.
			//lfs.viewExtension = ".cfm"; //eg. you would set this if you need to specify that include files are some other extension, such as ".cfi"

			//3) Optional Settings - These are not needed to be set by LightFront, unless you need that setting, such as for assignments or switch-style controllers.
			lfs.preEvent = "layout.header"; //I'm using this to display the header, but it can be used on any event that will always run before the requested event.
			lfs.postEvent = "layout.footer"; //I'm using this to display the footer, but it can be used on any event that will always run before the requested event.
			//lfs.defaultPage = "index.cfm"; //the default page for the controller. "index.cfm" is the default. It is possible to allow any page to access LightFront if you choose, though it's not recommended.
			//lfs.formURLPrecedence = "form"; //"form" or "URL". If you set to URL, url variables will overwrite form variables.

			//3a) Assignments - Assign a class to a controller/switch, if you want to allow assignments, particularly useful if you want a single controller.
			//If you are using the controller prefix/suffix, set up assignment post prefix/suffix.
			//This is similar to defining circuits in Fusebox.
			//lfs.assignments = structNew();
			//lfs.assignments.home = "controller"; // eg. admin.login = home.admin_login;

			//4) Switch-based Controllers - If you have switches (Fusebox 2-3 style controllers, represent them here, much like you would in a fusebox.init.cfm.
			lfs.switch = structNew();
			lfs.switch.switchVariable = "fuseaction"; //this will assign do to fuseaction.
			lfs.switch.switchPage = "switch.cfm"; //the name of the file.
			lfs.switch.switchRoot = "/controller/switch/";
			lfs.switch.switches = structNew();
			lfs.switch.switches.switch = "";
			lfs.switch.switches.test = "test/";
			return lfs;
		</cfscript>
	</cffunction>

</cfcomponent>
