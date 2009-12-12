<p>I am ./view/hello/goodbye.cfm, and I am called from a conventional Fusebox 2/3 style switch via an include, as shown here:</p>
<pre>
<span class="code">&lt;cfoutput&gt;
	&lt;cfswitch expression=<span class="codeattribute">&quot;#attributes.fuseaction#&quot;</span>&gt;
		&lt;cfcase value=<span class="codeattribute">&quot;hello&quot;</span>&gt;
			<span class="codecfpound">#<span class="function">displayView(<span class="functionattribute">&quot;hello.switchexample&quot;</span>)</span>#</span>
		&lt;/cfcase&gt;
		<span class="codecomment">&lt;cfcase value=<span class="codeattribute">&quot;goodbye&quot;</span>&gt;</span>
			<span class="codecomment">&lt;cfinclude template=<span class="codeattribute">&quot;../../view/hello/goodbye.cfm&quot;</span> /&gt;</span>
		<span class="codecomment">&lt;/cfcase&gt;</span>
		&lt;cfdefaultcase&gt;
			<span class="codehtml">&lt;p&gt;</span><span class="codecfpound">I am switch.#attributes.fuseaction#, and I don't exist.</span><span class="codehtml">&lt;/p&gt;</span>
		&lt;/cfdefaultcase&gt;
	&lt;/cfswitch&gt;
&lt;/cfoutput&gt;</span></pre>
<p>I am a good example of how LightFront can use a legacy application and even let you add to it. It respects this as the switch circuit.</p>
<p>Now, <a href="#link('switch.solong')#">say so long</a>! This will give you a friendly error message.</p>
<p>What if in your old Fusebox application you don't use &quot;do&quot;? No problem. Check setSettingsForLightFront() in Application.cfc and change local.eventVariable to the variable name you need.</p>