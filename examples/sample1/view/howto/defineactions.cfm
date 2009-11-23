<h2>How do I define my actions (events)?</h2>
<p>Note: In the next release of LightFront, callEvent() will be renamed callAction(), and all references to &quot;events&quot; will be changed to &quot;actions&quot;, which is more appropriate. Since this functionality is available now, we'll refer to actions, rather than events.</p>
<ul>
	<li><strong>CFC-based Controller:</strong> Define a method in the correct class-named CFC. For example, if you have a &quot;home&quot; class, there should be a home.cfc located in /lfront/controller, usually defined in /{site root}/controller or /{approot}/controller. In home.cfc, there should be a method that matches the name of the method. In other words, ?do=home.welcome looks for a welcome() function/method in {approot}/controller/home.cfc.<br /><br />
		e.g. ?do=home.welcome - here is what {site root}/controller/home.cfc might look like (with only one method), where you are calling a service called &quot;my&quot;:<br />
		<pre>
<span class="code">&lt;cfcomponent displayname=<span class="codeattribute">&quot;home&quot;</span> extends=<span class="codeattribute">&quot;org.lightfront.lightfront&quot;</span> output=<span class="codeattribute">&quot;true&quot;</span>&gt;</span>

	<span class="code">&lt;cfset variables.myService = <span class="function">initService(<span class="codeattribute">&quot;my&quot;</span>)</span> /&gt;

	&lt;cffunction name=<span class="codeattribute">&quot;welcome&quot;</span> access=<span class="codeattribute">&quot;public&quot;</span> output=<span class="codeattribute">&quot;true&quot;</span>&gt;
		&lt;cfargument name=<span class="codeattribute">&quot;args&quot;</span> type=<span class="codeattribute">&quot;struct&quot;</span> required=<span class="codeattribute">&quot;true&quot;</span> /&gt;
		&lt;cfset var myWelcome = myService.<span class="function">getWelcome(<span class="functionattribute">username=arguments.args.username</span>)</span> /&gt;
		&lt;cfreturn <span class="function">displayView(<span class="functionattribute">&quot;home.welcome&quot;</span>,<span class="functionattribute">myWelcome</span>)</span> /&gt;
	&lt;/cffunction&gt;

&lt;/cfcomponent&gt;</span></pre>
	</li>
	<li><strong>Switch-based Controller:</strong> For a switch-based controller, on the same action, you would do the following in {approot}/controller/switch/home/switch.cfm:
		<pre>
<span class="code">&lt;cfset variables.myService = <span class="function">initService(<span class="functionattribute">"my"</span>)</span> /&gt;
&lt;cfset args = arguments.args /&gt;

&lt;cfswitch expression=<span class="codeattribute">"#attributes.fuseaction#"</span>&gt;
	&lt;cfcase value=<span class="codeattribute">"welcome"</span>&gt;
		&lt;cfset myWelcome = myService.<span class="function">getWelcome(<span class="functionattribute">username=args.username</span>)</span> /&gt;
		&lt;cfreturn <span class="function">displayView(<span class="functionattribute">"home.welcome"</span>,<span class="functionattribute">myWelcome</span>)</span> /&gt;
	&lt;/cfcase&gt;
&lt;/cfswitch&gt;</span>
	</pre>
	</li>
	<li><strong>No Controller:</strong> Where you are going to access a view as an action, you would do the following in /view/home/welcome.cfm:
		<pre>
<span class="code">&lt;cfset variables.myService = <span class="function">initService(<span class="functionattribute">"my"</span>)</span> /&gt;
&lt;cfoutput&gt;</span>
	...code that accesses presents variables.myService in the rest of welcome.cfm, as needed.
<span class="code">&lt;/cfoutput&gt;</span>
		</pre>
	</li>
	<li><strong>On initService(&quot;my&quot;):</strong> That call to the lightfront.cfc will either use application.lfront.service.my or do a:
<pre>
<span class="function">createObject(<span class="functionattribute">&quot;component&quot;</span>,<span class="functionattribute">&quot;#settings.serviceRoot#.#settings.servicePrefix#my#settings.serviceSuffix#&quot;</span>)</span>
<span class="codecomment">//where settings = application.lfront.settings.</span>
</pre>
It saves that component to application.lfront.service.my so it's available as the application needs it from now on.</>
<p></p>
<p>e.g. (pseudo code of what's happening in the initService() call):
<pre>
<span class="code">&lt;cffunction name=<span class="codeattribute">&quot;initService&quot;</span>&gt;</span>
	...
	<span class="code">&lt;cfif <span class="function">structKeyExists(<span class="functionattribute">application.lfront.service</span>,<span class="functionattribute">&quot;my&quot;</span>)</span>&gt;
		&lt;cfset obj = application.lfront.service.my /&gt;
	&lt;cfelse&gt;
		&lt;cfset obj = <span class="function">createObject(<span class="functionattribute">&quot;component&quot;</span>,<span class="functionattribute">&quot;lfront.model.myService&quot;</span>)</span> /&gt;
		&lt;cfset application.lfront.service.my = obj /&gt;
	&lt;/cfif&gt;
	&lt;cfreturn obj /&gt;
&lt;/cffunction&gt;</span>
</pre>
	</li>
</ul>