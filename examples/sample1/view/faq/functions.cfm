<h2>Some frameworks require you to know a lot of extras to use them. What functions or commands do I need to learn for LightFront?</h2>
<p>There are only a few functions you'll need to know with LightFront:</p>
<ul>
	<li><strong>displayView()</strong> - This is the function you'll probably use more than any other. You use this in your controller actions, and you may call other views within a view.</li>
	<li><strong>callAction()</strong> - You call other controller actions with this function. This is possible, but if you're using a single controller, you're better off calling the function directly. You might want to use this if switching back and forth between switch controllers and CFC-based controllers. This function replaces callEvent(), which has been deprecated.</li>
	<li><strong>link()</strong> - You'll use the link function for links within LightFront. This can be best seen within views.</li>
	<li><strong>relocate()</strong> - This is a replacement for cflocation, used to keep you within the framework. This uses a client side redirect via JavaScript.</li>
	<li><strong>initService()</strong> - This is used to call your services within your model. You would use this in your controller CFCs.</li>
	<li><strong>initComponent()</strong> - If your model isn't flat (one CFC per object), you would use initComponent within your service CFCs for dependency injection. You would call it via application.lfront.initComponent() or your services need to extend lightfront.cfc.</li>
	<li><strong>getSetting()</strong> - Use to display a LightFront setting, such as the default page or default controllerAction, which is an automatically calculated setting, which is the defaultController + actionDelimiter (usually ".") + defaultAction.</li>
	<li><strong>logError()</strong> - You can use LightFront's built-in log creator to log any errors.</li>
</ul>
<p>There are also a few functions you may want to set up in your Application.cfc:</p>
<ul>
	<li><strong>isLightFront()</strong> - This is especially useful if you don't want all requests to go through LightFront.</li>
	<li><strong>allowDump()</strong> - This is a function to determine if you will allow ?dump=show to show a dump of the cgi, request, variables, and application scopes.</li>
</ul>