<h2>How do I install LightFront?</h2>
<h3>Read the README!</h3>
<p>Refer to the <a href="../faq/README.txt">README</a> first! This will give you the basics on how to install LightFront.</p>
<p>Once you have done that, you have a few options on how to install LightFront:</p>
<ol>
	<li>Unzip LightFront to a folder, but not to where you want to run LightFront from. We'll want to move around the core first.</li>
	<li>Assuming you are planning to build your first LightFront application, choose the examples/skeleton as your starting point. There is a more verbose skeleton at examples/skeleton_verbose if you're setting up a LightFront application for the first time. Or, if you just want to see LightFront in application, choose one of the other sample applications in examples.</li>
	<li>Copy the application of your choice to your desired location. You can install it anywhere, either at your site root or in a subfolder. You may want to create a virtual host to this directly along with a HOSTS file entry to point to this site, such as:
		<pre>
	127.0.0.1	lightfront.dev
		</pre>
	<li>Install org/lightfront/lightfront.cfc either at your webroot or, if you are using a virtual host, the root of the virtual host. If you can install the entire application at the root, this is the easiest install.</li>
	<li>Depending on how you add /org/lightfront/lightfront.cfc, you may need to create a mapping to /org/lightfront in your ColdFusion admin to /org/lightfront. This is required if you are running LightFront on ColdFusion MX 7 and are not creating a virtual host for the application.</li>
	<li>You may also choose to keep lightfront.cfc at the root of your site as an alternative. In that case, update the &quot;extends&quot; value in Application.cfc and any controller CFCs to point to the correct location.</li>
	<li>Create an application mapping in your Application.cfc to /org/lightfront to the location where you place lightfront. HOWEVER, this will mean you have to change the extends value in the cfcomponent tag in Application.cfc. Your extends can't be &quot;org.lightfront.lightfront&quot; in that tag if you are defining that mapping in Application.cfc, as the extends value won't be recognized.</li>
	<li>Unsupported in the current version <em>(experimental)</em>: Remove the extends parameter from the cfcomponent tag, and then initialize lightfront.cfc in your onApplicationStart() as application.lightfront. <em>(Note: We will offer a sample like this for version 0.4.5.)</em></li>
	<li>Create a mapping to &quot;lfront&quot; to the root of your application. This is shown in the skeleton application in Application.cfc. If you are running ColdFusion MX 7, the &quot;lfront&quot; mapping needs to be completed within ColdFusion administrator.</li>
	<li>Try going to the URL you set up for the LightFront app. If you are correctly connected to it, you will get a success page. If you get an error message, refer to the <a href="../faq/README.txt">README</a> for more hints. If you're still stuck, try subscribing to the <a href="http://groups.google.com/groups/lightfront">Google Group</a> (requires approval to eliminate spammers) and post your issue there or try the <a href="http://lightfront.riaforge.org/index.cfm?event=page.projectcontact">contact form</a>.</li>
	<li>If you decide to move your model, controller, and/or view from their default locations, such as moving them off the root (common is one directory behind the root), define those in the setCustomLightFrontSettings() function in your Application.cfc and provide mappings for those locations as well.</li>
	<li>Set any other custom settings, such as defaultClass, defaultMethod, actionVariable (0.4.4), actionDelimiter (0.4.4), if you have any switch controllers, controller/service prefixes/suffixes, assignments (map one class name to another), using another defaultPage name and others in setCustomLightFrontSettings() as well.</li>
	<li>If you are using LightFront with a legacy application and want to keep the existing page structure (i.e. not use a central index.cfm hub), move the loadRequest() call from onRequestStart() to onRequestEnd() to use LightFront in that situation, or remove it entirely and call the functions in your page.</li>
</ol>
