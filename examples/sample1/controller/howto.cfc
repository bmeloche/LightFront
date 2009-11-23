<cfcomponent displayname="howto" extends="org.lightfront.lightfront" output="false" hint="howto">

	<cffunction name="onMissingMethod" returntype="string" output="false">
		<cfargument name="missingMethodName" type="string" required="true" hint="The name of the missing method." />
		<cfargument name="missingMethodArguments" type="struct" required="false" hint="The arguments that were passed to the missing method. This might be a named argument set or a numerically indexed set." />
		<cfset var lfront = structNew() />
		<cfset lfront.displayCurrentPage = displayView("howto/#arguments.missingMethodName#") />
		<cfif arguments.missingMethodName NEQ "howto">
			<cfset lfront.howto = displayView("howto/howto") />
		<cfelse>
			<cfset lfront.howto = "" />
		</cfif>
		<cfreturn lfront.displayCurrentPage & lfront.howto />
	</cffunction>
</cfcomponent>
