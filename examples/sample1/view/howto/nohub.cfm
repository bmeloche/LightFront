<h2>Can I use LightFront without a central hub?</h2>
<p>Yes, this is especially important to support legacy applications, and this feature is fairly unique to LightFront. FW/1 can also support it, but you don't have quite as much flexibility as you do with LightFront.</p>
<p>There are four ways to incorporate LightFront into an existing, previously non-frameworked application:</p>
<ol>
	<li>LightFront allows you to incorporate old standalone files. The easiest to do if you are planning to convert your application to LightFront, you can use existing files as your controllers and actions. For example, you could re-route main/contactus.cfm as ?do=main.contactus.</li>
	<li>If you still want to LightFront CAN be called from old standalone files. There is not an example application to show this yet, but this has been tested. To do it, change your Application.cfc call to loadRequest() from your onRequestStart() to your onRequestEnd() function. This allows the standalone template to be called BEFORE LightFront is called and then display the results when the output is rendered.</li>
	<li>Loading loadRequest() is NOT a requirement when calling LightFront (not yet supported, but possible). To do this, you would need to perform some of the functionality within your template that loadRequest() would do, such as:
		<ul>
			<li>Creating the request.attributes scope from url and form values (this will be separated into a loadAttributes() function in version 0.4.5);</li>
			<li>Running any pre- and post-actions;</li>
		</ul>
	You could save callAction() to a variable or use loadAction to load the action result into the request scope and call displayViews as needed.</li>
	<li>Application.cfm support - It is possible to use LightFront with an Application.cfm. There is not a sample application that shows how to do this, but this will be added in version 0.4.5.</li>
</ol>
