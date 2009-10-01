<cfcomponent displayname="Application" extends="lightfront" output="false" hint="I am the Application CFC. I am tied to Lightfront.">
	<cfscript>
		//Set the application properties. Customize to meet your needs.
		this.name = "lightfront_" & hash(getCurrentTemplatePath());
		this.applicationTimeout = createTimeSpan(2,0,0,0);
		this.sessionManagement = true;
		this.sessionTimeout = createTimeSpan(0,0,30,0);
		this.cookieManagement = true;
		this.setClientCookies = false;
		this.mappings["lightfront"] = expandPath("./");
		this.mappings["controller"] = expandPath("./controller");
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
		<cfset var local = structNew() />
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
		<!---<cfif application.lfront.settings.allowNonDefaultPages IS false AND compareNoCase("/index.cfm",listLast(arguments.targetPage,'.')) IS false>
			<cfset retBool = false />
		</cfif>--->
		<!--- Customize here - Add additional logic to prove/disprove this is a Lightfront request. --->
		<cfreturn retBool />
	</cffunction>

	<cffunction name="getSettingsForLightFront" access="private" returntype="struct" hint="I set LightFront settings.">
		<cfscript>
			//LightFront settings set here, loaded in onApplicationStart().
			var local = structNew();
			local.startupTimeout = 60;
			local.cfcControllerDirectory = "./controller/";
			local.controllerPrefix = ""; //eg. prefix = "lf": class = home, controller = lfhome.cfc.
			local.controllerSuffix = ""; //eg. suffix = "controller": class = home, controller = homecontroller.cfc.
			local.viewDirectory = "./view/";
			//local.modelDirectory = "/model/";
			local.eventVariable = "do"; // eg. index.cfm?do=home.welcome; event = do; class = home; method = welcome;
			local.eventDelimiter = ".";
			local.classVariable = "section";
			local.methodVariable = "action"; //this is also used for switch/Fusebox 2-3 style controllers.
			local.methodSwitch = true;
			local.defaultClass = "home"; //used if no classes are defined.
			local.defaultMethod = "welcome";
			local.defaultEvent = local.defaultClass & local.eventDelimiter & local.defaultMethod;
			local.defaultPage = "index.cfm"; //the default page for the controller. It is possible to allow any page to access LightFront if you choose, though it's not recommended.
			local.formURLPrecedence = "form"; //"form" or "URL". If you set to URL, url variables will overwrite form variables.
			local.lightfrontRoot = true;
			local.preEvent = "layout.header";
			local.postEvent = "layout.footer";
			local.reload = "reload";
			local.reloadpassword = "true";
			//Assignments - Assign a class to a controller/switch, if you want to allow assignments, particularly useful if you want a single controller.
			//If you are using the controller prefix/suffix, set up assignment post prefix/suffix.
			//This is similar to defining circuits in Fusebox.
			local.assignments = structNew();
			//local.assignments.home = "controller"; // eg. admin.login = home.admin_login;
			//Switches - If you have switches (Fusebox 2-3 style controllers, represent them here, much like you would in a fusebox.init.cfm.
			local.switch = structNew();
			local.switch.switchVariable = "fuseaction";
			local.switch.switchPage = "switch.cfm";
			local.switch.switchRoot = "./controller/switch/";
			local.switch.switches = structNew();
			local.switch.switches.switch = "";
			local.switch.switches.test = "test/";
			return local;
		</cfscript>
	</cffunction>

</cfcomponent>
