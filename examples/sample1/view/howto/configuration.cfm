<h2>What do I need to configure in LightFront? Where? How?</h2>
<p>Where is the easy one, so we'll discuss that first. Everything you need to configure is in Application.cfc. LightFront doesn't have much to configure, but there are a few required things to config, and many more that are optional.</p>
<p>Everything you need to configure is located in the setCustomLightFrontSettings() function, located at the bottom of Application.cfc. These are referenced as application.lfront.settings[settingName] or getSetting(settingName) throughout your application. getSetting() is designed to work for simple values only Returning arrays, structures, queries or objects may yield unexpected results.</p>
<h4>Whoa! Look down there! I thought you said that LightFront wasn't complicated! THAT'S A LOT OF SETTINGS!</h4>
<h2>TAKE A DEEP BREATH! Every required setting has a default!!!</h2>
<h3>Required settings by LightFront (with defaults):</h3>
<p>Though there are a fair number of settings that need to be set, every required setting has a default. Essentially, you only have to set a required setting if you don't follow its conventional location.</p>
<ul>
	<li><strong>settings.applicationMode</strong> -Will control whether a LightFront application can be initialized and whether the scopes can be dumped. Allowed values will be &quot;development-reload&quot; (reloads the application and dumps the scope on each request), &quot;development&quot; (reloads the application when the reload variable and password are requested; dumps when the dump password is supplied), &quot;test&quot; (same as development, but dump requires you to be on the localhost), &quot;staging&quot; (same as test, but both require you to be on the localhost) and &quot;production&quot; (will require the ColdFusion administrator password to allow the reload and dump, and must be done on the localhost).  settings.applicationMode is currently a dummy field in 0.4.3 for reference and added for future compatibility. <em><strong>Default is &quot;development&quot;</strong></em>.</li>
	<li><strong>settings.startupTimeout</strong> - How long you'll give LightFront to startup. LightFront's very small and lightweight, so it doesn't need a lot of time to start up by itself, but your model might... so the default setting  is a conservative <strong><em>60 seconds</em></strong>.</li>
	<li><strong>settings.reload &amp; settings.reloadPassword</strong> - Reload is the variable name you wish to use to reinitialize or reload the application, and its password to do so. <em><strong>Default is &quot;reload&quot; for reload and &quot;true&quot; for the password</strong></em>. To restart the application, you would call <a href="/?reload=true">/?reload=true</a>. Try it! In production environments, it is strongly recommended to change these defaults!</li>
	<li><strong>settings.CFCControllerDirectory</strong> - LightFront assumes you will be using CFC-based controllers. Whether you use them or not, you must define a valid directory (one that exists). That directory can have no files in it, but any .cfc files will be initialized by the framework. Keep all of your controller CFCs in this folder, and do not put CFCs in any subfolders. <strong><em>Default is &quot;/lfront/controller/&quot;</em></strong>.</li>
	<li><strong>settings.controllerPrefix &amp; settings.controllerSuffix</strong> - If you need to apply a naming convention to your controllers, you would add those here. e.g. If the &quot;home&quot; class needs to be called &quot;lFrontHomeController&quot;, you would set controllerPrefix to &quot;lFront&quot; and controllerSuffix to &quot;Controller&quot;. <strong><em>Both have &quot;&quot; as their defaults</em>.</strong></li>
	<li><strong>settings.viewDirectory</strong> - Your views must all be contained in a viewDirectory. Unlike your CFC controllers, your views can exist nested in subfolders. However, make sure there's a common view directory. <em><strong>Default is &quot;/lfront/view/&quot;</strong></em>. <em>(Note: It is possible to get around this issue with virtual directories/aliases and ColdFusion mappings, but why not keep it simple? by just containing a simple common views directory? Trust me... you'll thank me later!)</em></li>
	<li><strong>settings.serviceRoot</strong> - Your root to find your services. This is used by initService(). <strong><em>Default is &quot;lfront.model&quot;</em></strong>.</li>
	<li><strong>settings.servicePrefix &amp; settings.serviceSuffix</strong> - Much like controllers, you may set a default prefix and suffix for your service CFCs. <strong><em>Defaults are &quot;&quot; for both settings</em></strong>.</li>
	<li><strong>settings.modelRoot</strong> - Your root to find your model CFCs. This is used by initComponent() to define where to find where these CFCs are: <strong><em>Default is &quot;lfront.model&quot;</em></strong>.</li>
	<li> <strong>settings.dump</strong>, <strong>settings.dump.allow </strong> &amp; <strong>settings.dump.password</strong> - These three variables are set by default, and allow you to show a dump of CGI, variables, request and application scopes. settings.dump is a structure. By default, <strong>allow is set to true</strong> and the <strong>password is &quot;show&quot;</strong>. You are strongly encouraged to set these three variables yourself in setCustomLightFrontSettings() rather than accept the defaults.<br />
	</li>
	<li><strong>Your action structure (event structure, until 0.4.4) </strong>, defined by the eventVariable, consists of: A class, an event delimiter, and a method. For class and method, you must define defaults, and LightFront does not define a default for you. After 0.4.4, all <strong>&quot;event&quot;</strong> references throughout LightFront will be renamed <strong>&quot;action&quot;</strong> to clear up some misunderstandings about LightFront and how it is not an implicit-invocation event-driven framework, but rather an explicit invocation framework (LightFront calls the actions directly).
		<ul>
			<li><strong>settings.eventVariable</strong> (replaced by settings.actionVariable in 0.4.4) - This is how you call an event, such as /?do=home.welcome. <em><strong>&quot;do&quot; is the default</strong></em> name for this variable, but it can be anything you see fit, such as: event, go, fuseaction, page or action.</li>
			<li><strong>settings.eventDelimiter</strong> - The separator in the event between class and method. The <strong><em>default is &quot;.&quot;</em></strong> but other examples you could define are &quot;:&quot;, &quot;,&quot; or &quot;_&quot;.
			<li><strong>settings.defaultClass</strong> - Class is the first part of your event, before the eventDelimiter. When hitting LightFront without a class defined, the default class will be added. If the event only has one element, the default class will be added to the event. <strong><em>&quot;main&quot; is the default</em></strong>. If &quot;main&quot; is the value, your application should have a /lfront/controller/main.cfc or /lfront/controller/switch/main/{switchFile}.</li>
			<li><strong>settings.defaultMethod</strong> - This is the default method that LightFront will use if one is not defined in the request. You may choose &quot;init&quot; or something else. In this sample application, welcome is the default. <strong><em>&quot;home&quot; is the default</em></strong> setting. This would mean that if you have a main.cfc (see previous setting), you would either need a &quot;home&quot; function/method or have an &quot;onMissingMethod&quot; to handle the call.</li>
			<li><strong>settings.defaultPage</strong> - The hub page. <strong><em>&quot;index.cfm&quot; is the default</em></strong>.</li>
			<li><strong>settings.viewExtension</strong> - The extension used for view pages, used if your organization obfuscates what extension is being used for CFML. <strong><em>&quot;.cfm&quot; is the default.</em></strong><em></em></li>
		</ul>
	</li>
</ul>
<h3>Optional settings by LightFront (not required, but must be set in order to be active in your application):</h3>
<p>LightFront's optional settings need to be set, and none of them have any defaults. These settings are 100% customizable to your needs, but that also means they require configuration settings that you must set in order to have those settings available to you.</p>
<h4>Assignments</h4>
<ul>
	<li><strong>settings.assignments</strong> - If you want to set class assignments, where one class name would be pointed to another, you want assignments. Assignments allow you to point one class to another, and are very valuable in small applications, where you want a different class in the URL but want to maintain a single controller.would set settings.assignments to a structure, then set the appropriate assignments. e.g. If you want any actions beginning with &quot;home&quot; to go to main.cfc instead, you would have a setCustomLightFrontSettings() set as shown below:
		<pre>
<span class="code">&lt;cffunction name=<span class="codeattribute">&quot;setCustomLightFrontSettings&quot;</span> access=<span class="codeattribute">&quot;private&quot;</span> returntype=<span class="codeattribute">&quot;struct&quot;</span> hint=<span class="codeattribute">&quot;I set LightFront application settings.&quot;</span>&gt;
	&lt;cfscript&gt;</span>
		var settings = <span class="function">structNew()</span>;
		settings.applicationMode = <span class="codeattribute">&quot;testing&quot;</span>;
		<span class="codehighlight">settings.assignments = <span class="function">structNew()</span>; <span class="scriptcomment">//create an &quot;assignments&quot; structure.</span></span>
		<span class="codehighlight">settings.assignments.home = <span class="codeattribute">&quot;main&quot;</span>; <span class="scriptcomment">//action with &quot;home&quot; class will use main.cfc instead.</span></span>
		return <span class="codeattribute">settings</span>;
	<span class="code">&lt;/cfscript&gt;
&lt;/cffunction&gt;</span></pre></li>
</ul>
<p>You can also use assignments in multiple controller applications, and they can be used for all types of LightFront-supported controllers.</p>
<h4>Switch-based (Fusebox 2/3) Controllers</h4>
<p>LightFront offers support for Fusebox 2/3 style controllers, where you can use a switch file as a controller. This allows you to repurpose existing code, plus this style of controller is still very popular today. The following settings are required to use switch-based controllers.</p>
<ul>
	<li><strong>settings.switch</strong> - If you have Fusebox 2/3 style switch controllers in your LightFront application, you need to set this structure. In addition, there are several other settings within settings.switch that also need to be configured as a result of enabling switch controllers.</li>
	<li><strong>settings.switch.switchVariable</strong> - This is the value your switches will use to activate the switch. If you are using &quot;fuseaction&quot; in applications today, you can also use it in LightFront.</li>
	<li><strong>settings.switch.switchPage</strong> - This is the name of switch pages. In Fusebox 3 pages, these were usually called fbx_switch.cfm, but you can name them anything you want, as long as you keep it consistent throughout the LightFront application.</li>
	<li><strong>settings.switch.switchRoot</strong> - The main root directory where your switch pages or &quot;circuits&quot; are located.</li>
	<li><strong>settings.switch.switches</strong> - Now you need to define your switches or circuits. You start this by defining a structure, and then define each switch within settings.switch.switches.</li>
	<li>Here is an example of setCustomLightFrontSettings() for a LightFront application using switch-based controllers:
		<pre>
<span class="code">&lt;cffunction name=<span class="codeattribute">&quot;setCustomLightFrontSettings&quot;</span> access=<span class="codeattribute">&quot;private&quot;</span> returntype=<span class="codeattribute">&quot;struct&quot;</span> hint=<span class="codeattribute">&quot;I set LightFront application settings.&quot;</span>&gt;
	&lt;cfscript&gt;</span>
		var settings = <span class="function">structNew()</span>;
		settings.applicationMode = <span class="codeattribute">&quot;testing&quot;</span>;
		<span class="codehighlight">settings.switch = <span class="function">structNew()</span>;</span>
		<span class="codehighlight">settings.switch.switchVariable = <span class="codeattribute">&quot;fuseaction&quot;</span>; <span class="scriptcomment">//this will assign do to fuseaction.</span></span>
		<span class="codehighlight">settings.switch.switchPage = <span class="codeattribute">&quot;switch.cfm&quot;</span>; <span class="scriptcomment">//the name of the switch file. This might be called fbx_switch.cfm if you are porting over a Fusebox app.</span></span>
		<span class="codehighlight">settings.switch.switchRoot = <span class="codeattribute">&quot;/lfront/controller/switch/&quot;</span>; <span class="scriptcomment">//The root where LightFront will look for switch-based controllers.</span></span>
		<span class="codehighlight">settings.switch.switches = <span class="function">structNew()</span>; <span class="scriptcomment">//Now you define you switches. This is very similar to what you do in an fbx_circuits.cfm.</span></span>
		<span class="codehighlight">settings.switch.switches.switch = <span class="codeattribute">&quot;&quot;</span>; <span class="scriptcomment">//The &quot;switch&quot; switch controller is located at the switchRoot.</span></span>
		<span class="codehighlight">settings.switch.switches.test = <span class="codeattribute">&quot;test/&quot;</span>; <span class="scriptcomment">//The &quot;test&quot; switch controller is located at /lfront/controller/switch/test/.</span></span>
		return <span class="codeattribute">settings</span>;
	<span class="code">&lt;/cfscript&gt;
&lt;/cffunction&gt;</span></span>
		</pre>
	</li>
</ul>
