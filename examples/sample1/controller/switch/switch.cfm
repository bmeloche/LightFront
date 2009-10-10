<cfoutput>
	<cfswitch expression="#attributes.fuseaction#">
		<cfcase value="hello">
			#displayView("hello.switchexample")#
		</cfcase>
		<cfcase value="goodbye">
			<cfinclude template="../../view/hello/goodbye.cfm" />
		</cfcase>
		<cfdefaultcase>
			<p>I am switch.#attributes.fuseaction#, and I don't exist.</p>
		</cfdefaultcase>
	</cfswitch>
</cfoutput>