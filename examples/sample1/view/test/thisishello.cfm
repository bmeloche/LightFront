<p>If you see this, this means that you have successfully done the following:</p>
<ol>
	<li>Gotten to /controller/switch/test/switch.cfm.</li>
	<li>switch.cfm properly called attributes.fuseaction = hello.</li>
	<li>The hello fuseaction called /view/test/thisishello.cfm by using displayView("test.thisishello"). Note that displayView will only work within the specified in application.lfront.settings.viewDirectory (<cfoutput>#application.lfront.settings.viewDirectory#</cfoutput>, './view/' by default if not specified.).</li>
</ol>
<p>That means that your switches can use callEvent() and displayView().</p>
<p><a href="/LGRC.bak">Right-click and install</a></p>
