<cfcomponent displayname="utilities" output="false" hint="I am a utility CFC, used throughout the application. Some of the following functions were based on user defined functions found at cflib.org, written in cfscript. Rewritten in tag-based format by Brian Meloche (brianmeloche@gmail.com) November 15, 2009.">

	<cffunction name="createGUID" access="public" returntype="string" output="false" hint="Returns a UUID in the Microsoft form. Based on a UDF written by Nathan Dintenfass (nathan@changemedia.com); submitted to cflib.org July 17, 2001.">
		<cfreturn insert("-",createUUID(),23)>
	</cffunction>

	<cffunction name="isGUID" access="public" returntype="boolean" output="false" hint="Returns true if the string is a valid MSSQL GUID. Based on a UDF written by Michael Slatoff (michael@slatoff.com). Rewritten in version 2 by Raymond Camden (ray@camdenfamily.com) for cflib.org October 2, 2002.">
		<cfargument name="str" type="string" required="true" hint="String to be checked (Required).">
		<cfreturn (reFindNoCase("[0-9a-f]{8,8}-[0-9a-f]{4,4}-[0-9a-f]{4,4}-[0-9a-f]{4,4}-[0-9a-f]{12,12}",str) EQ 1 AND len(str) EQ 36)>
	</cffunction>

	<cffunction name="isUUID" access="public" returntype="boolean" output="false" hint="Returns true if the string is a valid CF UUID. Based on a UDF written by Jason Ellison (jgedev@hotmail.com); submitted to cflib.org November 24, 2003.">
		<cfargument name="str" type="string" required="true" hint="String to be checked (Required).">
		<cfreturn (reFindNoCase("^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", str))>
	</cffunction>

</cfcomponent>