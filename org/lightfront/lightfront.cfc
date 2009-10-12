<!--- Copyright (c) 2009, Brian Meloche

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License. --->
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
		<cfset var lfs = structNew() />
		<cftry>
			<cfset lfs.settings = arguments.settings />
			<cfset lfs.settings.lightfrontVersion = "0.3.5" />
			<cfparam name="lfs.settings.applicationMode" type="string" default="development" />
			<cfparam name="lfs.settings.startupTimeout" type="numeric" default="60" />
			<cfparam name="lfs.settings.reload" type="string" default="reload" />
			<cfparam name="lfs.settings.reloadpassword" type="string" default="true" />
			<cfparam name="lfs.settings.cfcControllerDirectory" type="string" default="/lf/controller/" />
			<cfparam name="lfs.settings.viewDirectory" type="string" default="/lf/view/" />
			<cfparam name="lfs.settings.controllerPrefix" type="string" default="" />
			<cfparam name="lfs.settings.controllerSuffix" type="string" default="" />
			<cfparam name="lfs.settings.defaultClass" type="string" default="main" />
			<cfparam name="lfs.settings.defaultMethod" type="string" default="default" />
			<cfparam name="lfs.settings.eventDelimiter" type="string" default="." />
			<cfparam name="lfs.settings.eventVariable" type="string" default="do" />
			<cfparam name="lfs.settings.defaultPage" type="string" default="index.cfm" />
			<cfparam name="lfs.settings.viewExtension" type="string" default=".cfm" />
			<cfset lfs.settings.defaultEvent = lfs.settings.defaultClass & lfs.settings.eventDelimiter & lfs.settings.defaultMethod />
			<cfif NOT structKeyExists(lfs.settings,"dump")>
				<cfset lfs.settings.dump = structNew() />
				<cfset lfs.settings.dump.allow = true />
				<cfset lfs.settings.dump.password = "show" />
			<cfelseif NOT structKeyExists(lfs.settings.dump,"allow") OR NOT structKeyExists(lfs.settings.dump,"password")>
				<cfthrow message="Dump settings only partially provided. Missing allow or password setting." detail="dump.allow and/or dump.password is not provided in the application." />
			</cfif>
			<cfreturn lfs.settings />
			<cfcatch type="Any">
				<cflog application="true" file="lightFrontException" type="error" text="loadSettings(): #cfcatch.message# #cfcatch.detail#" />
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="loadControllers" access="public" returntype="struct" output="false" hint="I load the Lightfront controllers into the application.">
		<cfset var loc = structNew() />
		<cftry>
			<cfset setSettings() />
			<cfset loc.controllers = structNew() />
			<!--- Step 1: Load CFC Controllers. This is a convention. We assume all LightFront applications have a cfc-based controller. --->
			<cfset loc.searchKey = iif(structKeyExists(settings,"controllerPrefix"),DE(settings.controllerPrefix),DE("")) & "*" & iif(structKeyExists(settings,"controllerSuffix"),DE(settings.controllerSuffix),DE("")) & ".cfc" />
			<cfdirectory action="list" directory="#expandPath(settings.cfcControllerDirectory)#" filter="#settings.controllerPrefix#*#settings.controllerSuffix#.cfc" name="loc.controllerList" recurse="true" />
			<cfloop query="loc.controllerList">
				<cfset loc.tempController = trim(replaceNoCase(loc.controllerList.name,".cfc","")) />
				<cfif loc.tempController NEQ "">
					<cfset loc.controllers[loc.tempController] = structNew() />
					<cfset loc.controllers[loc.tempController]["controllerType"] = "cfc" />
					<cfset loc.controllers[loc.tempController]["controller"] = createObject("component","lf.controller.#loc.tempController#") />
				</cfif>
			</cfloop>
			<!--- Step 2: Switch controllers (Fusebox 2/3 style). --->
			<cfif structKeyExists(settings,"switch") AND structKeyExists(settings.switch,"switchRoot") AND structKeyExists(settings.switch,"switches")>
				<cfloop collection="#settings.switch.switches#" item="loc.tempController">
					<cfset loc.controllers[loc.tempController] = structNew() />
					<cfset loc.controllers[loc.tempController]["controllerType"] = "switch" />
					<cfset loc.controllers[loc.tempController]["controller"] = settings.switch.switchRoot & settings.switch.switches[loc.tempController] & settings.switch.switchPage />
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
		<cfset loc.retEvent = "" />
		<cfset request.attributes.class = listFirst(arguments.event,getSetting("eventDelimiter")) />
		<cfset request.attributes.method = listLast(arguments.event,getSetting("eventDelimiter")) />
		<cfif (structKeyExists(application.lfront.settings,"assignments") AND structKeyExists(application.lfront.settings.assignments,request.attributes.class))>
			<cfset request.attributes.origclass = request.attributes.class />
			<cfset request.attributes.class = application.lfront.settings.assignments[request.attributes.origclass] />
		</cfif>
		<cfif structKeyExists(application.lfront.ctrl,request.attributes.class)>
			<cfset loc.controller = getController(request.attributes.class) />
			<cfif loc.controller.controllerType IS "cfc">
				<cfinvoke component="#loc.controller.controller#" method="#request.attributes.method#" returnvariable="loc.retEvent">
					<cfif structKeyExists(arguments,"args")>
						<cfinvokeargument name="args" value="#arguments.args#" />
					</cfif>
				</cfinvoke>
			<cfelseif loc.controller.controllerType IS "switch">
				<cfset request.attributes[uCase(application.lfront.settings.switch.switchVariable)] = request.attributes.method />
				<cfset variables.attributes = request.attributes />
				<cfsavecontent variable="loc.retEvent"><cfinclude template="#loc.controller.controller#" /></cfsavecontent>
			<cfelse>
				<cfthrow message="Controller Type #loc.controller.controllerType# is not recognized." />
			</cfif>
		<cfelse>
			<cfsavecontent variable="loc.retEvent">#displayView(request.attributes.class & "." & request.attributes.method)#</cfsavecontent>
		</cfif>
		<cfset request.eventCounter = request.eventCounter + 1 />
		<cfif isDefined("loc.retEvent")>
			<cfreturn loc.retEvent />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

	<cffunction name="displayView" access="public" returntype="string" output="false" hint="I display views.">
		<cfargument name="viewName" type="string" required="true" />
		<cfargument name="content" type="any" required="false" hint="Use this if you want to pass content to the view." />
		<cfset var loc = structNew() />
		<cfset arguments.viewName = replaceNoCase(arguments.viewName,getSetting('eventDelimiter'),"/","ALL") />
		<cfset loc.viewFile = arguments.viewName & getSetting("viewExtension") />
		<cfset loc.viewName = getSetting("viewDirectory") & loc.viewFile />
		<cfset loc.renderedView = "" />
		<cfset loc.viewError = "LightFront Error: #arguments.viewName# is not found! Looking for #loc.viewName#." />
		<cfif FileExists(ExpandPath(loc.viewName))>
			<cfsavecontent variable="loc.renderedView"><cfinclude template="#loc.viewName#" /></cfsavecontent>
		<cfelseif structKeyExists(application.lfront.settings,"assignments") AND structKeyExists(application.lfront.settings,"switch") AND structKeyExists(application.lfront.settings.switch,"switchPage")>
			<cfset loc.switchName = getSetting("viewDirectory") & replace(arguments.viewName,listLast(arguments.viewName,"/"),"") & application.lfront.settings.switch.switchPage />
			<cfif FileExists(ExpandPath(loc.switchName))>
				<cfset request.attributes[uCase(settings.switch.switchVariable)] = listLast(arguments.viewName,"/") />
				<cfset variables.attributes = request.attributes />
				<cfsavecontent variable="loc.renderedView"><cfinclude template="#loc.switchName#" /></cfsavecontent>
			<cfelse>
				<cfset loc.renderedView = loc.viewError /> 
			</cfif>
		<cfelse>
			<cfset loc.renderedView = loc.viewError />
		</cfif>
		<cfreturn loc.renderedView />
	</cffunction>

	<cffunction name="relocate" access="public" returntype="string" output="false" hint="I redirect to another event.">
		<cfargument name="event" type="string" required="true" />
		<cfargument name="qstring" type="string" required="false" />
		<cfset var relo = getSetting('eventVariable') />
		<cfsavecontent variable="relo"><cfoutput><script>location.href = "./?#relo#=#arguments.event#<cfif structKeyExists(arguments,"qstring")>&#arguments.qstring#</cfif>";</script></cfoutput></cfsavecontent>
		<cfreturn trim(relo) />
	</cffunction>

	<cffunction name="getController" access="private" returntype="any" output="true" hint="I add the appropriate controller.">
		<cfargument name="controllerName" type="string" required="true" />
		<cftry>
			<cfif structKeyExists(application.lfront.ctrl,arguments.controllerName)>
				<cfreturn application.lfront.ctrl[arguments.controllerName] />
			<cfelse>
				<cfreturn application.lfront.settings.viewDirectory & "/" & arguments.controllerName & "/" />
			</cfif>
			<cfcatch type="any">
				<cflog application="true" file="lightFrontException" type="error" text="getController(): #cfcatch.message# #cfcatch.detail#" />
				<cfrethrow />
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