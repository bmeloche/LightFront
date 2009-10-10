<cfoutput>
	<cfswitch expression="#attributes.fuseaction#">
		<cfcase value="hello">
			#displayView("test.thisishello")#
		</cfcase>
		<cfdefaultcase>
			<cfdump var="#attributes.fuseaction#" />
	    </cfdefaultcase>
	</cfswitch>
</cfoutput>