<!--- <cfif isDefined("thisTag.executionMode") AND thisTag.executionMode NEQ "start">
	<cfexit method="exittag" />
</cfif>
<!---
Watch out!  Make sure you use CFOUTPUT for all outputting.
--->
<cfsetting enablecfoutputonly="true" />
<!---
These are the control variables that can be predefined by the including
template to alter behaviour.
--->
<cfparam name="variables.fuseactionVariable" default="do" />
<cfparam name="variables.defaultFuseaction" default="__default_fuseaction__" />
<cfif NOT structKeyExists(variables, "self")>
	<cfset variables.self = "#getPageContext().getRequest().getContextPath()##cgi.script_name#?#fuseactionVariable#=" />
</cfif>
<cfparam name="variables.appSearchPath" default=".,.." />
<cfparam name="variables.templateExtensions" default="cfm,cfml,htm,html" />
<cfparam name="variables.allowMultipleCircuits" default="true" />
<cfparam name="variables.circuitSeparator" default="." />

<!---
The do() UDF.  It accepts a fuseaction and an optional contentVariable
name.  If the content variable already exists, it will be appended to;
there is no facility to overwrite, you must do it manually.
--->
<cffunction name="do">
	<cfargument name="_fb3lite_fuseaction" type="string" required="true" />
	<cfargument name="_fb3lite_contentVariable" type="string" required="false" />
	<cfset var oldFuseaction = attributes.currentFuseaction />
	<cfset var oldCircuitPath = circuitPath />
	<cfset var fa = _fb3lite_fuseaction />
	<cfif _fb3lite_fuseaction CONTAINS circuitSeparator AND allowMultipleCircuits>
		<cfset fa = listLast(_fb3lite_fuseaction, circuitSeparator) />
		<cfset circuitPath = circuitPath & "/" & left(_fb3lite_fuseaction, len(_fb3lite_fuseaction) - len(fa) - 1) />
	</cfif>
	<cfset attributes.currentFuseaction = fa />
	<cfif structKeyExists(arguments, "_fb3lite_contentVariable")>
		<cfparam name="#_fb3lite_contentVariable#" default="" />
		<cfsavecontent variable="#_fb3lite_contentVariable#"><cfoutput>#variables[_fb3lite_contentVariable]#</cfoutput>
			<cfinclude template="#circuitPath#/fbx_Switch.cfm" />
		</cfsavecontent>
	<cfelse>
		<cfinclude template="#circuitPath#/fbx_Switch.cfm" />
	</cfif>
	<cfset attributes.currentFuseaction = oldFuseaction />
	<cfset circuitPath = oldCircuitPath />
</cffunction>

<!---
The include() UDF.  It accepts a template filename, and an optional
contentVariable name.  If the content variable already exists, it will
be appended to; there is no facility to overwrite, you must do it
manually.
--->
<cffunction name="include">
	<cfargument name="_fb3lite_template" type="string" required="true" />
	<cfargument name="_fb3lite_contentVariable" type="string" required="false" />
	<cfif listFind(templateExtensions, listLast(_fb3lite_template, ".")) EQ 0>
		<cfset _fb3lite_template = _fb3lite_template & ".cfm" />
	</cfif>
	<cfif structKeyExists(arguments, "_fb3lite_contentVariable")>
		<cfparam name="#_fb3lite_contentVariable#" default="" />
		<cfsavecontent variable="#_fb3lite_contentVariable#"><cfoutput>#variables[_fb3lite_contentVariable]#</cfoutput>
			<cfinclude template="#circuitPath#/#_fb3lite_template#" />
		</cfsavecontent>
	<cfelse>
		<cfinclude template="#circuitPath#/#_fb3lite_template#" />
	</cfif>
</cffunction>

<!---
The location() UDF.  It accepts a destination URL and uses CFLOCATION
to redirect.
--->
<cffunction name="location" output="false">
	<cfargument name="_fb3lite_destUrl" type="string" required="true" />
	<cflocation url="#_fb3lite_destUrl#" addtoken="false" />
</cffunction>

<!---
Figure out where the circuit is by searching the 'appSearchPath' control
variable.
--->
<cfset circuitPath = "." />
<cfloop list="#appSearchPath#" index="path">
	<cfif fileExists(getDirectoryFromPath(getCurrentTemplatePath()) & path & "/fbx_Switch.cfm")>
		<cfset circuitPath = path />
		<cfbreak />
	</cfif>
</cfloop>

<!---
FormUrl2Attributes.
--->
<cfif NOT isDefined("attributes") OR NOT isStruct(attributes)>
	<cfset attributes = structNew() />
</cfif>
<cfset structAppend(attributes, form, false) />
<cfset structAppend(attributes, url, false) />

<!---
Set up the framework variables.
--->
<cfparam name="attributes.#fuseactionVariable#" default="#defaultFuseaction#" />
<cfset attributes.fuseaction = attributes[fuseactionVariable] />
<cfset attributes.originalFuseaction = attributes.fuseaction />
<cfset attributes.currentFuseaction = attributes.fuseaction />

<!---
Run the request.
--->
<cfset do("onRequestStart") />
<cfset do(attributes.originalFuseaction) />
<cfset do("onRequestEnd") /> --->
