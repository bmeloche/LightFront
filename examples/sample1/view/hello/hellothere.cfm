<h2>Hello! I am ./view/home/hellothere.cfm!</h2>
<cfoutput>
	<cfif request.attributes.do IS "home.hello">
		<h3>I was called as displayView("home/hellothere")</h3>
	<cfelseif structKeyExists(arguments,"content") AND structKeyExists(arguments.content,"onMissingMethod")>
		<h3>I was called by onMissingMethod, looking for the action: #arguments.content.missingMethodArguments.args.do#.</h3>
	</cfif>
</cfoutput>