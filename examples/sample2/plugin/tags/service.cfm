<!--- 
LightFront Framework: plugin/tags/service.cfm
Optional service custom tag. Used to access your model from within your controllers.

Copyright (c) 2009, Brian Meloche

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License. --->
<cfif thisTag.executionMode EQ "start">
	<cfparam name="attributes.service" type="string" default="" />
	<cfparam name="attributes.method" type="string" default="" />
	<cfparam name="attributes.args" type="struct" default="#structNew()#" />
	<cfif NOT structKeyExists(request,attributes.service)>
		<cfset request[attributes.service] = application.serviceFactory.getfoo() />
	</cfif>
</cfif>