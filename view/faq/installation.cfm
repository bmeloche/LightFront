<h2>How do I install LightFront?</h2>
<p>You have a few options on how to install LightFront:</p>
<ol>
	<li>Install org/lightfront/lightfront.cfc at the root of your web server and install the rest of the files in the folder you want to run a LightFront application in. If you can install the entire application at the root, this is the easiest install.</li>
	<li>Create a mapping in your ColdFusion admin to /org/lightfront to the folder where you place lightfront.cfc.</li>
	<li>Create an application mapping in your Application.cfc to /org/lightfront to the location where you place lightfront. HOWEVER, this will mean you have to change the extends value in the cfcomponent tag in Application.cfc. If you take this route, it is recommended you change it to extends=&quot;lightfront&quot; and place lightfront.cfc in the same directory as Application.cfc. Your extends can't be &quot;org.lightfront.lightfront in that tag if you are defining that mapping in Application.cfc, as the extends value won't be recognized.</li>
	<li>Unsupported in the current version <em>(experimental)</em>: Remove the extends parameter from the cfcomponent tag, and then initialize lightfront.cfc in your onApplicationStart() as application.lightfront.</li>
</ol>