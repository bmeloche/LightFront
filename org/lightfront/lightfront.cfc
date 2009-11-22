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

	<cffunction name="loadSettings" access="public" returntype="struct" output="false" hint="I load the settings, and set any necessary defaults.">
		<cfargument name="settings" type="struct" required="true" />
		<cfset var lfront = structNew() />
		<cftry>
			<cfset lfront.settings = arguments.settings />
			<cfset lfront.settings.lightFrontVersion = "0.4.3" />
			<cfparam name="lfront.settings.applicationMode" type="string" default="development" />
			<cfparam name="lfront.settings.startupTimeout" type="numeric" default="60" />
			<cfparam name="lfront.settings.reload" type="string" default="reload" />
			<cfparam name="lfront.settings.reloadPassword" type="string" default="true" />
			<cfparam name="lfront.settings.CFCControllerDirectory" type="string" default="/lfront/controller/" />
			<cfparam name="lfront.settings.viewDirectory" type="string" default="/lfront/view/" />
			<cfparam name="lfront.settings.serviceRoot" type="string" default="lfront.model" />
			<cfparam name="lfront.settings.modelRoot" type="string" default="lfront.model" />
			<cfparam name="lfront.settings.controllerPrefix" type="string" default="" />
			<cfparam name="lfront.settings.controllerSuffix" type="string" default="" />
			<cfparam name="lfront.settings.servicePrefix" type="string" default="" />
			<cfparam name="lfront.settings.serviceSuffix" type="string" default="" />
			<cfparam name="lfront.settings.defaultClass" type="string" default="main" />
			<cfparam name="lfront.settings.defaultMethod" type="string" default="home" />
			<cfparam name="lfront.settings.eventDelimiter" type="string" default="." />
			<cfparam name="lfront.settings.eventVariable" type="string" default="do" />
			<cfparam name="lfront.settings.defaultPage" type="string" default="index.cfm" />
			<cfparam name="lfront.settings.viewExtension" type="string" default=".cfm" />
			<cfset lfront.settings.defaultEvent = lfront.settings.defaultClass & lfront.settings.eventDelimiter & lfront.settings.defaultMethod />
			<cfif NOT structKeyExists(lfront.settings,"dump")>
				<cfset lfront.settings.dump = structNew() />
				<cfset lfront.settings.dump.allow = true />
				<cfset lfront.settings.dump.password = "show" />
			<cfelseif NOT structKeyExists(lfront.settings.dump,"allow") OR NOT structKeyExists(lfront.settings.dump,"password")>
				<cfthrow message="Dump settings only partially provided. Missing allow or password setting." detail="dump.allow and/or dump.password is not provided in the application." />
			</cfif>
			<cfreturn lfront.settings />
			<cfcatch type="Any">
				<cflog application="true" file="lFrontException" type="error" text="loadSettings(): #cfcatch.message# #cfcatch.detail#" />
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="loadControllers" access="public" returntype="struct" output="false" hint="I load the LightFront controllers into the application.">
		<cfset var lfront = structNew() />
		<cftry>
			<cfset setSettings() />
			<cfset lfront.controllers = structNew() />
			<!--- Step 1: Load CFC Controllers. This is a convention. We assume all LightFront applications have a cfc-based controller. --->
			<cfset lfront.searchKey = iif(structKeyExists(settings,"controllerPrefix"),DE(settings.controllerPrefix),DE("")) & "*" & iif(structKeyExists(settings,"controllerSuffix"),DE(settings.controllerSuffix),DE("")) & ".cfc" />
			<cfdirectory action="list" directory="#expandPath(settings.cfcControllerDirectory)#" filter="#settings.controllerPrefix#*#settings.controllerSuffix#.cfc" name="lfront.controllerList" recurse="true" />
			<cfloop query="lfront.controllerList">
				<cfset lfront.tempController = trim(replaceNoCase(lfront.controllerList.name,".cfc","")) />
				<cfif lfront.tempController NEQ "">
					<cfset lfront.controllers[lfront.tempController] = structNew() />
					<cfset lfront.controllers[lfront.tempController]["controllerType"] = "cfc" />
					<cfset lfront.controllers[lfront.tempController]["controller"] = createObject("component","lfront.controller.#lfront.tempController#") />
				</cfif>
			</cfloop>
			<!--- Step 2: Switch controllers (Fusebox 2/3 style). --->
			<cfif structKeyExists(settings,"switch") AND structKeyExists(settings.switch,"switchRoot") AND structKeyExists(settings.switch,"switches")>
				<cfloop collection="#settings.switch.switches#" item="lfront.tempController">
					<cfset lfront.controllers[lfront.tempController] = structNew() />
					<cfset lfront.controllers[lfront.tempController]["controllerType"] = "switch" />
					<cfset lfront.controllers[lfront.tempController]["controller"] = settings.switch.switchRoot & settings.switch.switches[lfront.tempController] & settings.switch.switchPage />
				</cfloop>
			</cfif>
			<cfreturn lfront.controllers />
			<cfcatch type="Any">
				<cflog application="true" file="lFrontException" type="error" text="loadControllers(): #cfcatch.message# #cfcatch.detail#" />
				<cfrethrow />
			</cfcatch>
		</cftry>
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
				<cflog application="true" file="lFrontException" type="error" text="getController(): #cfcatch.message# #cfcatch.detail#" />
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="setSettings" access="private" returnType="void" hint="I make application.lfront.settings variables.settings.">
		<cfset variables.settings = application.lfront.settings />
	</cffunction>

	<!--- Framework Functions --->
	<cffunction name="loadRequest" hint="I pull the page request exclusively into LightFront. This is NOT used in a no-hub setup, like where you aren't routing all requests through index.cfm.">
		<cfargument name="requestVar" type="string" required="true" default="eventResult" />
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
		<!--- Run pre-event, if one is specified in the configs. Store it in a separate request variable if one is defined. --->
		<cfif structKeyExists(settings,"preEvent")>
			<cfif structKeyExists(settings,"preEventRequest")>
				<cfset request[settings.preEventRequest] = callEvent(settings.preEvent) />
			<cfelse>
				<cfset request[arguments.requestVar] = request[arguments.requestVar] & callEvent(settings.preEvent) />
			</cfif>
		</cfif>
		<!--- Run event. --->
		<cfif listLen(request.attributes[settings.eventVariable],settings.eventDelimiter) GT 2>
			<cfset request[arguments.requestVar] = request[arguments.requestVar] & displayView(request.attributes[settings.eventVariable]) />
		<cfelse>
			<cfset request[arguments.requestVar] = request[arguments.requestVar] & callEvent(request.attributes[settings.eventVariable],request.attributes) />
		</cfif>
		<!--- Run post-event, if one is specified in the configs. Store it in a separate request variable if one is defined. --->
		<cfif structKeyExists(settings,"postEvent")>
			<cfif structKeyExists(settings,"postEventRequest") AND settings.postEvent NEQ arguments.requestVar>
				<cfset request[settings.postEventRequest] = callEvent(settings.postEvent) />
			<cfelse>
				<cfset request[arguments.requestVar] = request[arguments.requestVar] & callEvent(settings.postEvent) />
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="loadAction" access="public" returntype="void" output="false" hint="I do a callAction() and save the result to the request scope.">
		<cfargument name="action" type="any" required="true" hint="I am the action to be called." />
		<cfargument name="args" type="struct" required="false" hint="I am used to pass in arguments directly to an action." />
		<cfargument name="var" type="string" required="true" hint="I am the request variable name to save the action to." />
		<cfset request[arguments.var] = callEvent(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="callAction" access="public" returntype="any" output="true" hint="I call the action (do). I will replace callEvent() in 0.4.4. I have been provided for forward compatibility.">
		<cfargument name="action" type="string" required="true" hint="I am the action to be called." />
		<cfargument name="args" type="any" required="false" hint="I am used to pass in arguments directly to an action." />
		<cfreturn callEvent(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="callEvent" access="public" returntype="any" output="true" hint="I invoke the event. This function will be deprecated in 0.4.4, and replaced by callAction().">
		<cfargument name="event" type="string" required="true" hint="I am the event to be called." />
		<cfargument name="args" type="any" required="false" hint="I am used to pass in arguments to an event." />
		<cfset var lfront = structNew() />
		<cfset lfront.retEvent = "" />
		<cfset request.attributes.class = listFirst(arguments.event,getSetting("eventDelimiter")) />
		<cfset request.attributes.method = listLast(arguments.event,getSetting("eventDelimiter")) />
		<cfif (structKeyExists(application.lfront.settings,"assignments") AND structKeyExists(application.lfront.settings.assignments,request.attributes.class))>
			<cfset request.attributes.origclass = request.attributes.class />
			<cfset request.attributes.class = application.lfront.settings.assignments[request.attributes.origclass] />
		</cfif>
		<cfif structKeyExists(application.lfront.ctrl,request.attributes.class)>
			<cfset lfront.controller = getController(request.attributes.class) />
			<cfif lfront.controller.controllerType IS "cfc">
				<cftry>
					<cfinvoke component="#lfront.controller.controller#" method="#request.attributes.method#" returnvariable="lfront.retEvent">
						<cfif structKeyExists(arguments,"args")>
							<cfinvokeargument name="args" value="#arguments.args#" />
						</cfif>
					</cfinvoke>
					<cfcatch type="any">
						<cfset request.errorStruct = cfcatch />
						<cfsavecontent variable="lfront.retEvent"><cfdump var="#cfcatch#"></cfsavecontent>
					</cfcatch>
				</cftry>
			<cfelseif lfront.controller.controllerType IS "switch">
				<cfset request.attributes[uCase(application.lfront.settings.switch.switchVariable)] = request.attributes.method />
				<cfset variables.attributes = request.attributes />
				<cfsavecontent variable="lfront.retEvent"><cfinclude template="#lfront.controller.controller#" /></cfsavecontent>
			<cfelse>
				<cfset request.errorStruct = structNew() />
				<cfset request.errorStruct.message = "Controller Type #lfront.controller.controllerType# is not recognized." />
			</cfif>
		<cfelse>
			<cfsavecontent variable="lfront.retEvent">#displayView(request.attributes.class & "/" & request.attributes.method)#</cfsavecontent>
		</cfif>
		<cfif structKeyExists(lfront,"retEvent")>
			<cfreturn lfront.retEvent />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

	<cffunction name="initService" access="public" returntype="any" output="true" hint="I invoke the service.">
		<cfargument name="serviceName" type="string" required="true" hint="" />
		<cfargument name="load" type="boolean" required="true" default="true" />
		<cfset var lfront = structNew() />
		<cfset setSettings() />
		<cfif structKeyExists(application.lfront,"service") AND structKeyExists(application.lfront.service,arguments.serviceName)>
			<cfreturn application.lfront.service[arguments.serviceName] />
		<cfelse>
			<cfset lfront.service = iif(structKeyExists(settings,"servicePrefix"),DE(settings.servicePrefix),DE("")) & arguments.serviceName & iif(structKeyExists(settings,"serviceSuffix"),DE(settings.serviceSuffix),DE("")) />
			<cfset lfront.serviceComponent = createObject("component","#settings.serviceRoot#.#lfront.service#") />
			<cfif arguments.load>
				<cfif NOT structKeyExists(application.lfront,"service")>
					<cfset application.lfront.service = structNew() />
				</cfif>
				<cfset application.lfront.service[arguments.serviceName] = lfront.serviceComponent />
			</cfif>
			<cfreturn lfront.serviceComponent />
		</cfif>
	</cffunction>

	<cffunction name="initComponent" access="public" returntype="any" output="true" hint="I initialize a component, usually in the model, for the application to use. I should be called in onApplicationStart() and set to application.lfront.initComponent.">
		<cfargument name="componentName" type="string" required="true" hint="the component name, in dot notation." />
		<cfargument name="useModelRoot" type="string" required="true" default="true" hint="Declare whether or not to use the modelRoot defined in LightFront's settings. Allows you to use this function elsewhere and to use it for things other than in the model." />
		<cfargument name="load" type="boolean" required="true" default="true" hint="Do I load this component in the application scope or not?" />
		<cfset var lfront = structNew() />
		<cfif structKeyExists(application.lfront,"model") AND structKeyExists(application.lfront.model,arguments.componentName)>
			<cfreturn application.lfront.model[arguments.componentName] />
		<cfelse>
			<cfif arguments.useModelRoot>
				<cfset lfront.component = createObject("component","#getSetting('modelRoot')#.#arguments.componentName#") />
			<cfelse>
				<cfset lfront.component = createObject("component",arguments.componentName) />
			</cfif>
			<cfif arguments.load>
				<cfif NOT structKeyExists(application.lfront,"model")>
					<cfset application.lfront.model = structNew() />
				</cfif>
				<cfset application.lfront.model[arguments.componentName] = lfront.component />
			</cfif>
			<cfreturn lfront.component />
		</cfif>
	</cffunction>

	<cffunction name="displayView" access="public" returntype="string" output="false" hint="I display views.">
		<cfargument name="viewName" type="string" required="true" />
		<cfargument name="content" type="any" required="false" hint="Use this if you want to pass content to the view." />
		<cfset var lfront = structNew() />
		<cfset arguments.viewName = replaceNoCase(arguments.viewName,getSetting('eventDelimiter'),"/","ALL") />
		<cfset lfront.viewFile = arguments.viewName & getSetting("viewExtension") />
		<cfset lfront.viewName = getSetting("viewDirectory") & lfront.viewFile />
		<cfset lfront.renderedView = "" />
		<cfset lfront.viewError = "LightFront Error: #arguments.viewName# is not found! Looking for #lfront.viewName#." />
		<cfif FileExists(ExpandPath(lfront.viewName))>
			<cfsavecontent variable="lfront.renderedView"><cfinclude template="#lfront.viewName#" /></cfsavecontent>
		<cfelseif structKeyExists(application.lfront.settings,"assignments") AND structKeyExists(application.lfront.settings,"switch") AND structKeyExists(application.lfront.settings.switch,"switchPage")>
			<cfset lfront.switchName = getSetting("viewDirectory") & replace(arguments.viewName,listLast(arguments.viewName,"/"),"") & application.lfront.settings.switch.switchPage />
			<cfif FileExists(ExpandPath(lfront.switchName))>
				<cfset request.attributes[uCase(settings.switch.switchVariable)] = listLast(arguments.viewName,"/") />
				<cfset variables.attributes = request.attributes />
				<cfsavecontent variable="lfront.renderedView"><cfinclude template="#lfront.switchName#" /></cfsavecontent>
			<cfelse>
				<cfset request.errorStruct = structNew() />
				<cfset request.errorStruct.message = lfront.viewError />
			</cfif>
		<cfelse>
				<cfset request.errorStruct = structNew() />
				<cfset request.errorStruct.message = lfront.viewError />
		</cfif>
		<cfreturn lfront.renderedView />
	</cffunction>

	<cffunction name="relocate" access="public" returntype="string" output="false" hint="I redirect to another event.">
		<cfargument name="event" type="string" required="true" />
		<cfargument name="qstring" type="string" required="false" />
		<cfset var relo = getSetting("eventVariable") />
		<cfsavecontent variable="relo"><cfoutput><script>location.href = "./?#relo#=#arguments.event#<cfif structKeyExists(arguments,"qstring")>&#arguments.qstring#</cfif>";</script></cfoutput></cfsavecontent>
		<cfreturn trim(relo) />
	</cffunction>

	<cffunction name="getSetting" access="public" returnType="any" hint="I get a setting.">
		<cfargument name="setting" type="string" required="true" hint="I am the setting I want to retrieve." />
		<cfreturn application.lfront.settings[arguments.setting]>
	</cffunction>

</cfcomponent>