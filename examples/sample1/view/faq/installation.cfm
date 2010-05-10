<h2>How do I install LightFront?</h2>
<p>You have a few options on how to install LightFront:</p>
<ol>
	<li>Create an Application.cfc. It should extend lightfront.cfc, whereever you decide to put it. You may want to take either the skeleton or the verbose skeleton as your Application.cfc template.</li>
	<li>Install lightfront.cfc at the root of your web application. You can also install lightfront.cfc elsewhere, just make sure Application.cfc extends it.</li>
	<li>In your Application.cfc, create an application mapping called &quot;lfront&quot; application's root. Alternatively, or if you are using ColdFusion MX 7, you may need to create a mapping in your ColdFusion administrator.</li>
	<li>Unsupported in the current version <em>(experimental)</em>: Remove the extends parameter from the cfcomponent tag, and then initialize lightfront.cfc in your onApplicationStart() as application.lightfront. <em>(Note: We may offer an install like this in later versions if there's a demand for it.)</em></li>
	<li>If using Application.cfm instead of Application.cfc, it may be possible to use LightFront, but that use is currently unsupported.</li>
</ol>