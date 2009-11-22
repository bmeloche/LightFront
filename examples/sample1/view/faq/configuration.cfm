<h2>What do I need to configure in LightFront? Where? How?</h2>
<p>Where is the easy one, so we'll discuss that first. Everything you need to configure is in Application.cfc. LightFront doesn't have much to configure, but there are a few required things to config, and many more that are optional.</p>
<p>Everything you need to configure is located in the setCustomLightFrontSettings() function, located at the bottom of Application.cfc.</p>
<h4>Required settings by LightFront (with defaults)</h4>
<p>Though there are a fair number of settings that need to be set, every required setting has a default. Essentially, you only have to set a required setting if you don't follow its convention.</p>
<ul>
	<li><strong>lfs.startupTimeout</strong> - How long you'll give LightFront to startup. LightFront's very small and lightweight, so it doesn't need a lot of time to start up by itself, but your model might... so the setting you'll see in Application.cfc is a conservative 60 seconds.</li>
	<li><strong>Your event structure</strong>, defined by the eventVariable, consists of: A class, an event delimiter, and a method. For class and method, you must define defaults, and LightFront does not define a default for you.
		<ul>
			<li><strong>lfs.eventVariable</strong> - This is how you call an event, such as /?do=home.welcome. &quot;do&quot; is the default name for this variable, but it can be anything you see fit, such as: event, go, fuseaction, page or action.</li>
			<li><strong>lfs.defaultClass</strong> - Class is the first part of your event, before the eventDelimiter. When hitting LightFront without a class defined, the default class will be added. If the event only has one element, the default class will be added to the event. In this example, home is the default class.</li>
			<li><strong>lfs.eventDelimiter</strong> - The separator in the event between class and method. The default is &quot;.&quot; but other examples you could define are &quot;:&quot;, &quot;,&quot; or &quot;_&quot;.
			<li><strong>lfs.defaultMethod</strong> - This is the default method that LightFront will use if one is not defined in the request. You may choose &quot;default&quot; or something else. In this sample application, welcome is the default. &quot;default&quot; is the default.</li>
		</ul>
	</li>
	<li><strong>lfs.reload &amp; lfs.reloadpassword</strong> - Used to reload the application. In the sample application, reload is set to reload, and password is set to true. To restart the application, you would call <a href="/?reload=true">/?reload=true</a>. Try it!</li>
	<li><strong>lfs.cfcControllerDirectory</strong> - LightFront assumes you will be using CFC-based controllers. Whether you use them or not, you must define a valid directory (one that exists). That directory can have no files in it, but any .cfc files will be initialized by the framework. Keep all of your controller CFCs in this folder, and do not put CFCs in any subfolders <strong><em>(default: /controller/)</em></strong>.</li>
	<li><strong>lfs.viewDirectory</strong> - Your views must all be contained in a viewDirectory. Unlike your CFC controllers, your views can exist nested in subfolders. However, make sure there's a common view directory. <em>(Note: It is possible to get around this issue with virtual directories/aliases and ColdFusion mappings, but why not keep it simple? by just containing a simple common views directory? Trust me... you'll thank me later!)</em></li>
</ul>
<h4>Optional settings by LightFront (not required to be defined)</h4>
<ul>
	<li>Coming soon... including Assignments &amp; Switch subsets.</li>
</ul>
