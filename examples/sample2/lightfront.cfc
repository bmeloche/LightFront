<!--- Copyright (c) 2009, 2010 Brian Meloche

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
			<cfset lfront.settings.lightFrontVersion = "0.4.4" />
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
			<cfparam name="lfront.settings.defaultController" type="string" default="main" />
			<cfparam name="lfront.settings.defaultAction" type="string" default="home" />
 			<cfparam name="lfront.settings.actionDelimiter" type="string" default="." />
			<cfparam name="lfront.settings.actionVariable" type="string" default="do" />
			<cfset lfront.settings.defaultControllerAction = lfront.settings.defaultController & lfront.settings.actionDelimiter & lfront.settings.defaultAction />
			<cfparam name="lfront.settings.defaultEntry" type="string" default="index" />
			<cfparam name="lfront.settings.cfmExtension" type="string" default="cfm" />
			<cfparam name="lfront.settings.defaultPage" type="string" default="#lfront.settings.defaultEntry#.#lfront.settings.cfmExtension#" />
			<cfparam name="lfront.settings.defaultRequestVar" type="string" default="actionResult" />
			<cfif NOT structKeyExists(lfront.settings,"dump")>
				<cfset lfront.settings.dump = structNew() />
				<cfset lfront.settings.dump.allow = true />
				<cfset lfront.settings.dump.password = "show" />
			<cfelseif NOT structKeyExists(lfront.settings.dump,"allow") OR NOT structKeyExists(lfront.settings.dump,"password")>
				<cfthrow message="Dump settings are only partially provided. Missing allow or password setting." detail="dump.allow and/or dump.password is not provided in the application." />
			</cfif>
			<cfreturn lfront.settings />
			<cfcatch type="Any">
				<cfset logError("loadSettings(): #cfcatch.message# #cfcatch.detail#")>
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
			<cfif structKeyExists(settings,"switch") AND structKeyExists(settings.switch,"switchDirectory") AND structKeyExists(settings.switch,"switches")>
				<cfloop collection="#settings.switch.switches#" item="lfront.tempController">
					<cfset lfront.controllers[lfront.tempController] = structNew() />
					<cfset lfront.controllers[lfront.tempController]["controllerType"] = "switch" />
					<cfset lfront.controllers[lfront.tempController]["controller"] = settings.switch.switchDirectory & settings.switch.switches[lfront.tempController] & settings.switch.switchPage />
				</cfloop>
			</cfif>
			<cfreturn lfront.controllers />
			<cfcatch type="Any">
				<cfset logError("loadControllers(): #cfcatch.message# #cfcatch.detail#")>
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
				<cfset logError("getController(): #cfcatch.message# #cfcatch.detail#")>
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="setSettings" access="public" returntype="void" hint="I make application.lfront.settings variables.settings.">
		<cfset variables.settings = application.lfront.settings />
	</cffunction>

	<cffunction name="getSetting" access="public" returntype="any" hint="I get a setting.">
		<cfargument name="setting" type="string" required="true" hint="I am the setting I want to retrieve." />
		<cfreturn application.lfront.settings[arguments.setting]>
	</cffunction>

	<!--- Framework Functions --->
	<cffunction name="loadRequest" hint="I pull the page request exclusively into LightFront. This is NOT used in a no-hub setup, like where you aren't routing all requests through index.cfm.">
		<cfargument name="requestVar" type="string" required="true" default="#application.lfront.settings.defaultRequestVar#" />
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
		<cfparam name="request.attributes['#settings.actionVariable#']" default="#settings.defaultController##settings.actionDelimiter##settings.defaultAction#" />
		<!--- If you are running a single controller, it will replace the ontroller for the action with the defaultController. --->
		<cfif listLen(request.attributes[settings.actionVariable],settings.actionDelimiter) EQ 1>
			<cfset request.attributes[settings.actionVariable] = settings.defaultController & settings.actionDelimiter & request.attributes[settings.actionVariable] />
		</cfif>
		<cfset request.attributes[settings.actionVariable] = replace(request.attributes[settings.actionVariable],settings.actionDelimiter,".","ALL") />
		<!--- Run pre-action, if one is specified in the configs. Store it in a separate request variable if one is defined. --->
		<cfif structKeyExists(settings,"preAction")>
			<cfif structKeyExists(settings,"preActionRequest")>
				<cfset loadAction(settings.preActionRequest,settings.preAction) />
			<cfelse>
				<cfset request[arguments.requestVar] = request[arguments.requestVar] & callAction(settings.preAction) />
			</cfif>
		</cfif>
		<!--- Run action. --->
		<cfif listLen(request.attributes[settings.actionVariable],settings.actionDelimiter) GT 2>
			<!--- That means you want to run a view as an action (action). --->
			<cfset request[arguments.requestVar] = request[arguments.requestVar] & displayView(request.attributes[settings.actionVariable]) />
		<cfelse>
			<cfif arguments.requestVar NEQ application.lfront.settings.defaultRequestVar>
				<!--- In other words, you passed something other than the default for the request variable into loadRequest(). You'd want to do this in an AJAX/AMF request. You'll want to handle this in your onRequestEnd() or somewhere else in your application. Run loadAction() instead of callAction(). Basically, you're running this as a pre-Action or post-Action. --->
				<cfset loadAction(arguments.requestVar,request.attributes[settings.actionVariable],request.attributes)>
			<cfelse>
				<cfset request[arguments.requestVar] = request[arguments.requestVar] & callAction(request.attributes[settings.actionVariable],request.attributes) />
			</cfif>
		</cfif>
		<!--- Run post-action, if one is specified in the configs. Store it in a separate request variable if one is defined. --->
		<cfif structKeyExists(settings,"postAction")>
			<cfif structKeyExists(settings,"postActionRequest") AND settings.postAction NEQ arguments.requestVar>
				<cfset loadAction(settings.postActionRequest,settings.postAction) />
			<cfelse>
				<cfset request[arguments.requestVar] = request[arguments.requestVar] & callAction(settings.postAction) />
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="loadAction" access="public" returntype="void" output="false" hint="I do a callAction() and save the result to the request scope.">
		<cfargument name="requestVar" type="string" required="true" hint="I am the request variable name to save the action to." />
		<cfargument name="action" type="any" required="true" hint="I am the action to be called." />
		<cfargument name="args" type="struct" required="false" default="#request.attributes#" hint="I am used to pass in arguments directly to an action." />
		<cfset request[arguments.requestVar] = callAction(action=arguments.action,args=arguments.args) />
	</cffunction>

	<cffunction name="callEvent" access="public" returntype="any" output="true" hint="I call the action (do). I have been replaced by callAction() in 0.4.4. I have been provided for backward compatibility.">
		<cfargument name="event" type="string" required="true" hint="I am the event to be called." />
		<cfargument name="args" type="any" required="false" hint="I am used to pass in arguments directly to an event." />
		<cfset arguments.action = arguments.event />
		<cfreturn callAction(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="callAction" access="public" returntype="any" output="true" hint="I call the action (do).">
		<cfargument name="action" type="string" required="true" hint="I am the action to be called." />
		<cfargument name="args" type="any" required="false" hint="I am used to pass in arguments to an action." />
		<cfset var lfront = structNew() />
		<cfset lfront.retAction = "" />
		<cfset request.attributes.controller = listFirst(arguments.action,getSetting("actionDelimiter")) />
		<cfset request.attributes.action = listLast(arguments.action,getSetting("actionDelimiter")) />
		<cfif (structKeyExists(application.lfront.settings,"assignments") AND structKeyExists(application.lfront.settings.assignments,request.attributes.controller))>
			<cfset request.attributes.origController = request.attributes.controller />
			<cfset request.attributes.controller = application.lfront.settings.assignments[request.attributes.origcontroller] />
		</cfif>
		<cfif structKeyExists(application.lfront.ctrl,request.attributes.controller)>
		<cfset lfront.controller = getController(request.attributes.controller) />
			<cfif lfront.controller.controllerType IS "cfc">
				<cftry>
					<cfinvoke component="#lfront.controller.controller#" method="#request.attributes.action#" returnvariable="lfront.retAction">
						<cfif structKeyExists(arguments,"args")>
							<cfinvokeargument name="args" value="#arguments.args#" />
						</cfif>
					</cfinvoke>
					<cfcatch type="any">
						<cfset request.errorStruct = cfcatch />
						<cfset lfront.retAction = "">
					</cfcatch>
				</cftry>
			<cfelseif lfront.controller.controllerType IS "switch">
				<cfset request.attributes[uCase(application.lfront.settings.switch.switchVariable)] = request.attributes.action />
				<cfset variables.attributes = request.attributes />
				<cfsavecontent variable="lfront.retAction"><cfinclude template="#lfront.controller.controller#" /></cfsavecontent>
			<cfelse>
				<cfset request.errorStruct = structNew() />
				<cfset request.errorStruct.message = "Controller Type #lfront.controller.controllerType# is not recognized." />
			</cfif>
		<cfelse>
			<cfsavecontent variable="lfront.retAction">#displayView(request.attributes.controller & "/" & request.attributes.action)#</cfsavecontent>
		</cfif>
		<cfif structKeyExists(lfront,"retAction")>
			<cfreturn lfront.retAction />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

	<cffunction name="initService" access="public" returntype="any" output="true" hint="I initialize a service. I store it in the Application scope if you tell me to.">
		<cfargument name="serviceName" type="string" required="true" hint="" />
		<cfargument name="load" type="boolean" required="true" default="true" />
		<cfset var lfront = structNew() />
		<cfset lfront.settings = application.lfront.settings />
		<cfif structKeyExists(application.lfront,"service") AND structKeyExists(application.lfront.service,arguments.serviceName)>
			<cfreturn application.lfront.service[arguments.serviceName] />
		<cfelse>
			<cfset lfront.service = iif(structKeyExists(lfront.settings,"servicePrefix"),DE(lfront.settings.servicePrefix),DE("")) & arguments.serviceName & iif(structKeyExists(lfront.settings,"serviceSuffix"),DE(lfront.settings.serviceSuffix),DE("")) />
			<cfset lfront.serviceComponent = createObject("component","#lfront.settings.serviceRoot#.#lfront.service#") />
			<cfif arguments.load>
				<!--- Lock & Load!!! --->
				<cflock scope="Application" timeout="30" throwontimeout="true">
					<cfif NOT structKeyExists(application.lfront,"service")>
						<cfset application.lfront.service = structNew() />
					</cfif>
					<cfset application.lfront.service[arguments.serviceName] = lfront.serviceComponent />
				</cflock>
			</cfif>
			<cfreturn lfront.serviceComponent />
		</cfif>
	</cffunction>

	<cffunction name="initComponent" access="public" returntype="any" output="true" hint="I initialize a component, usually in the model, for the application to use. I should be called in onApplicationStart() and set to application.lfront.initComponent.">
		<cfargument name="componentName" type="string" required="true" hint="the component name, in dot notation." />
		<cfargument name="useModelRoot" type="boolean" required="true" default="true" hint="Declare whether or not to use the modelRoot defined in LightFront's settings. Allows you to use this function elsewhere and to use it for things other than in the model." />
		<cfargument name="load" type="boolean" required="true" default="true" hint="Do I load this component in the application scope or not?" />
		<cfset var lfront = structNew() />
		<cfif structKeyExists(application.lfront,"model") AND structKeyExists(application.lfront.model,arguments.componentName)>
			<cfreturn application.lfront.model[arguments.componentName] />
		<cfelse>
			<cfif arguments.useModelRoot>
				<cfset lfront.component = createObject("component","#application.lfront.settings.modelRoot#.#arguments.componentName#") />
			<cfelse>
				<cfset lfront.component = createObject("component",arguments.componentName) />
			</cfif>
			<cfif arguments.load>
				<!--- Lock & Load!!! --->
				<cflock scope="Application" timeout="30" throwontimeout="true">
					<cfif NOT structKeyExists(application.lfront,"model")>
						<cfset application.lfront.model = structNew() />
					</cfif>
					<cfset application.lfront.model[arguments.componentName] = lfront.component />
				</cflock>
			</cfif>
			<cfreturn lfront.component />
		</cfif>
	</cffunction>

	<cffunction name="displayView" access="public" returntype="string" output="false" hint="I display views.">
		<cfargument name="viewName" type="string" required="true" />
		<cfargument name="content" type="any" required="false" hint="Use this if you want to pass content to the view." />
		<cfset var lfront = structNew() />
		<!--- When calling links in custom tags, you need to pass getSetting and link to the request scope. --->
		<cfset request.getSetting = getSetting>
		<cfset request.link = link>
		<cfset arguments.viewName = replaceNoCase(arguments.viewName,getSetting('actionDelimiter'),"/","ALL") />
		<cfset lfront.viewFile = arguments.viewName & "." & getSetting("cfmExtension") />
		<cfset lfront.viewName = getSetting("viewDirectory") & lfront.viewFile />
		<cfset lfront.renderedView = "" />
		<cfset lfront.viewError = "LightFront Error: #arguments.viewName# is not found! Looking for #lfront.viewName#. #expandPath(lfront.viewName)#" />
		<cfif fileExists(expandPath(lfront.viewName))>
			<cfsavecontent variable="lfront.renderedView"><cfinclude template="#lfront.viewName#" /></cfsavecontent>
		<cfelseif structKeyExists(application.lfront.settings,"assignments") AND structKeyExists(application.lfront.settings,"switch") AND structKeyExists(application.lfront.settings.switch,"switchPage")>
			<cfset lfront.switchName = getSetting("viewDirectory") & replace(arguments.viewName,listLast(arguments.viewName,"/"),"") & application.lfront.settings.switch.switchPage />
			<cfif fileExists(expandPath(lfront.switchName))>
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

	<cffunction name="relocate" access="public" returntype="string" output="false" hint="I redirect to another action.">
		<cfargument name="controllerAction" type="string" required="true" hint="controller.action" />
		<cfargument name="qstring" type="string" required="true" default="" />
		<cfsavecontent variable="relo"><cfoutput><script>location.href = "#link(controllerAction=arguments.controllerAction,qstring=arguments.qstring)#";</script></cfoutput></cfsavecontent>
		<cfreturn trim(relo) />
	</cffunction>

	<cffunction name="link" access="public" returntype="string" output="false" hint="I make a new link.">
		<cfargument name="controllerAction" type="string" required="true" hint="controller.action" />
		<cfargument name="qstring" type="string" required="true" default="" />
		<cfif arguments.qstring NEQ "">
			<cfset arguments.qstring = "&" & arguments.qstring />
		</cfif>
		<cfreturn "./" & getSetting("defaultPage") & "?" & getSetting("actionVariable") & "=" & arguments.controllerAction & arguments.qstring />
	</cffunction>

	<cffunction name="logError" access="private" returntype="void" output="false" hint="I log the LightFront errors.">
		<cfargument name="message" type="string" required="true" default="" hint="I am the message to be logged." />
		<cflog application="true" file="lFrontException" type="error" text="#arguments.message#" />
	</cffunction>

</cfcomponent>