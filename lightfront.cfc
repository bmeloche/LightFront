<cfcomponent displayname="LightFront" output="true" hint="I am the LightFront framework.">
	<cfset variables.instance = structNew() />
	<cfparam name="request.eventCounter" type="numeric" default="0" />

	<cffunction name="loadLightFront" access="public" returntype="struct" hint="I load the LightFront framework into the application.">
		<cfset var local = structNew() />
		<cftry>
			<!--- Load new Lightfront controllers, which will set controllers (cfcs and cfms), and views. --->
			<cfset local.controllers = loadControllers() />
			<cfreturn local.controllers />
			<cfcatch type="Any">
				<cflog application="true" file="lightFrontException" type="error" text="loadLightFront(): #cfcatch.message# #cfcatch.detail#" />
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="loadSettings" access="public" returntype="struct" output="false" hint="I load the settings, and set any necessary defaults.">
		<cfargument name="settings" type="struct" required="true" />
		<cfset var loc = structNew() />
		<cfset loc.settings = arguments.settings />
		<cfset loc.settings.lightfrontVersion = "0.3.0" />
		<cfparam name="loc.settings.controllerPrefix" type="string" default="" />
		<cfparam name="loc.settings.controllerSuffix" type="string" default="" />
		<cfparam name="loc.settings.eventDelimiter" type="string" default="." />
		<cfparam name="loc.settings.eventVariable" type="string" default="do" />
		<cfreturn loc.settings />
	</cffunction>

	<cffunction name="loadControllers" access="public" returntype="struct" output="false" hint="I load the Lightfront controllers into the application.">
		<cfset var loc = structNew() />
		<cftry>
			<cfset setSettings() />
			<cfset loc.controllers = structNew() />
			<!--- Step 1: Load CFC Controllers. This is a convention. We assume all LightFront applications have a cfc-based controller. --->
			<cfset loc.expandedControllerPath = expandPath(settings.cfcControllerDirectory) />
			<cfset application.lfront.settings.controllerPath = loc.expandedControllerPath />
			<cfset loc.searchKey = iif(structKeyExists(settings,"controllerPrefix"),DE(settings.controllerPrefix),DE("")) & "*" & iif(structKeyExists(settings,"controllerSuffix"),DE(settings.controllerSuffix),DE("")) & ".cfc" />
			<cfdirectory action="list" directory="#loc.expandedControllerPath#" filter="#settings.controllerPrefix#*#settings.controllerSuffix#.cfc" name="loc.controllerList" recurse="true" />
			<cfloop query="loc.controllerList">
				<cfset loc.temp = trim(replaceNoCase(loc.controllerList.name,".cfc","")) />
				<cfif loc.temp NEQ "">
					<cfset loc.controllers[loc.temp] = structNew() />
					<cfset loc.controllers[loc.temp]["controllerType"] = "cfc" />
					<cfset loc.controllers[loc.temp]["controller"] = createObject("component","controller.#loc.temp#") />
				</cfif>
			</cfloop>
			<!--- Step 2: Switch controllers (Fusebox 2/3 style). --->
			<cfif structKeyExists(settings,"switch") AND structKeyExists(settings.switch,"switchRoot") AND structKeyExists(settings.switch,"switches")>
				<cfloop collection="#settings.switch.switches#" item="loc.temp">
					<cfset loc.controllers[loc.temp] = structNew() />
					<cfset loc.controllers[loc.temp]["controllerType"] = "switch" />
					<cfset loc.controllers[loc.temp]["controller"] = settings.switch.switchRoot & settings.switch.switches[loc.temp] & settings.switch.switchPage />
				</cfloop>
			</cfif>
			<cfreturn loc.controllers />
			<cfcatch type="Any">
				<cflog application="true" file="lightFrontException" type="error" text="loadControllers(): #cfcatch.message# #cfcatch.detail#" />
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="loadLightfrontRequest" access="public">
		<cfargument name="requestVar" type="string" required="true" default="eventResult" />
		<cfset var loc = structNew() />
		<cfset setSettings() />
		<cfif NOT structKeyExists(request,"attributes")>
			<!--- Create the LightFront request, if the request doesn't exist. An example would be if you are calling from a proxy. --->
			<cfset request.attributes = structNew() />
		</cfif>
		<cfif NOT structKeyExists(request,arguments.requestVar)>
			<cfset request[arguments.requestVar] = "" />
		</cfif>
		<cfif isDefined("settings") AND structKeyExists(settings,"formURLPrecedence") AND settings.formURLPrecedence EQ "form">
			<!--- Form overwrites URL. --->
			<cfset structAppend(request.attributes,URL) />
			<cfset structAppend(request.attributes,form) />
		<cfelse>
			<!--- URL overwrites Form. --->
			<cfset structAppend(request.attributes,form) />
			<cfset structAppend(request.attributes,URL) />
		</cfif>
		<cfparam name="request.attributes['#settings.eventVariable#']" default="#settings.defaultClass##settings.eventDelimiter##settings.defaultMethod#" />
		<!--- If you are running a single controller, it will replace the class for the event with the defaultClass. --->
		<cfif listLen(request.attributes[settings.eventVariable],settings.eventDelimiter) EQ 1>
			<cfset request.attributes[settings.eventVariable] = settings.defaultClass & settings.eventDelimiter & request.attributes[settings.eventVariable] />
		</cfif>
		<cfset request.attributes[settings.eventVariable] = replace(request.attributes[settings.eventVariable],settings.eventDelimiter,".","ALL") />
		<!--- Run pre-event, if one is specified in the configs. --->
		<cfif structKeyExists(settings,"preEvent")>
			<cfset request[arguments.requestVar] = request[arguments.requestVar] & callEvent(settings.preEvent) />
		</cfif>
		<!--- Run event. --->
		<cfset request.attributes.you = listLen(request.attributes[settings.eventVariable],settings.eventDelimiter) />
		<cfif listLen(request.attributes[settings.eventVariable],settings.eventDelimiter) GT 2>
			<cfset request[arguments.requestVar] = request[arguments.requestVar] & displayView(request.attributes[settings.eventVariable]) />
		<cfelse>
			<cfset request[arguments.requestVar] = request[arguments.requestVar] & callEvent(request.attributes[settings.eventVariable]) />
			<cfset request.thisis = request[arguments.requestVar] />
		</cfif>
		<!--- Run post-event, if one is specified in the configs. --->
		<cfif structKeyExists(settings,"postEvent")>
			<cfset request[arguments.requestVar] = request[arguments.requestVar] & callEvent(settings.postEvent) />
		</cfif>
	</cffunction>

	<cffunction name="callEvent" access="public" returntype="any" output="true" hint="I invoke the event.">
		<cfargument name="event" type="any" required="true" hint="" />
		<cfargument name="args" type="struct" required="false" hint="use to pass in arguments to an event" />
		<cfset var loc = structNew() />
		<cfset loc.temp = "" />
		<cfset request.attributes.class = listFirst(arguments.event,getSetting("eventDelimiter")) />
		<cfset request.attributes.method = listLast(arguments.event,getSetting("eventDelimiter")) />
		<cfif (structKeyExists(application.lfront.settings,"assignments") AND structKeyExists(application.lfront.settings.assignments,request.attributes.class))>
			<cfset request.attributes.origclass = request.attributes.class />
			<cfset request.attributes.class = application.lfront.settings.assignments[request.attributes.origclass] />
		</cfif>
		<cfif structKeyExists(application.lfront.ctrl,request.attributes.class)>
			<cfset loc.controller = getController(request.attributes.class) />
			<cfif loc.controller.controllerType IS "cfc">
				<cfinvoke component="#loc.controller.controller#" method="#request.attributes.method#" returnvariable="loc.temp">
					<cfif structKeyExists(arguments,"args")>
						<cfinvokeargument name="args" value="#arguments.args#" />
					</cfif>
				</cfinvoke>
			<cfelseif loc.controller.controllerType IS "switch">
				<cfset request.attributes[uCase(application.lfront.settings.switch.switchVariable)] = request.attributes.method />
				<cfset variables.attributes = request.attributes />
				<cfsavecontent variable="loc.temp">
					<cftry>
						<cfinclude template="#loc.controller.controller#" />
						<cfcatch type="any">
							<cfrethrow />
						</cfcatch>
					</cftry>
				</cfsavecontent>
			<cfelse>
				<cfthrow message="Controller Type #loc.controller.controllerType# is not recognized." />
			</cfif>
		<cfelse>
			<cfsavecontent variable="loc.temp">#displayView(request.attributes.class & "." & request.attributes.method)#</cfsavecontent>
		</cfif>
		<cfset request.eventCounter = request.eventCounter + 1 />
		<cfif isDefined("loc.temp")>
			<cfreturn loc.temp />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

	<cffunction name="displayView" access="public" returntype="string" output="false" hint="I display views.">
		<cfargument name="viewName" type="string" required="true" />
		<cfargument name="content" type="any" required="false" hint="Use this if you want to pass content to the view." />
		<cfset var loc = structNew() />
		<cfset arguments.viewName = replaceNoCase(arguments.viewName,getSetting('eventDelimiter'),"/","ALL") />
		<cfset loc.viewFile = arguments.viewName & ".cfm" />
		<cfset loc.viewName = getSetting("viewDirectory") & loc.viewFile />
		<cfif FileExists(ExpandPath(loc.viewName))>
			<cfsavecontent variable="loc.renderedView"><cfinclude template="#loc.viewName#" /></cfsavecontent>
		<cfelse>
			<cfset loc.switchName = getSetting("viewDirectory") & replace(arguments.viewName,listLast(arguments.viewName,"/"),"") & application.lfront.settings.switch.switchPage />
			<cfif FileExists(ExpandPath(loc.switchName))>
				<cfset request.attributes[uCase(settings.switch.switchVariable)] = listLast(arguments.viewName,"/") />
				<cfset variables.attributes = request.attributes />
				<cfsavecontent variable="loc.renderedView"><cfinclude template="#loc.switchName#" /></cfsavecontent>
			<cfelse>
				<cfsavecontent variable="loc.renderedView">Error: #arguments.viewName# is not found! Looking for #loc.viewName#.</cfsavecontent>
			</cfif>
		</cfif>
		<cfreturn loc.renderedView />
	</cffunction>

	<cffunction name="relocate" access="public" returntype="string" output="false" hint="I redirect to another event.">
		<cfargument name="event" type="string" required="true" />
		<cfargument name="qstring" type="string" required="false" />
		<cfset var relo = getSetting('eventVariable') />
		<cfsavecontent variable="relo">
			<cfoutput><script>location.href = "./?#relo#=#arguments.event#<cfif structKeyExists(arguments,"qstring")>&#arguments.qstring#</cfif>";</script></cfoutput>
		</cfsavecontent>
		<cfreturn trim(relo) />
	</cffunction>

	<cffunction name="getController" access="private" returntype="any" output="true" hint="I add controller. to class.">
		<cfargument name="controllerName" type="string" required="true" />
		<cftry>
			<cfif structKeyExists(application.lfront.ctrl,arguments.controllerName)>
				<cfreturn application.lfront.ctrl[arguments.controllerName] />
			<cfelse>
				<cfreturn application.lfront.settings.viewDirectory & "/" & arguments.controllerName & "/" />
			</cfif>
			<cfcatch type="any">
				<cfdump var="#cfcatch#" label="getController error!" />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="setSettings" access="private" returnType="void" hint="I make application.lfront.settings variables.settings.">
		<cfset variables.settings = application.lfront.settings />
	</cffunction>

	<cffunction name="getSetting" access="public" returnType="any" hint="I get a setting.">
		<cfargument name="setting" type="string" required="true" hint="I am the setting I want to retrieve." />
		<cfreturn application.lfront.settings[arguments.setting] />
	</cffunction>

</cfcomponent>