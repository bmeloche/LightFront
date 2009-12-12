<h2>Switch-based Controllers</h2>
<p>I am ./view/home/switchexample.cfm. I was called from ./controller/switch/switch.cfm.</p>
<p>Here's what the switch looks like:</p>
<pre>
<span class="code">&lt;cfoutput&gt;
	&lt;cfswitch expression=<span class="codeattribute">&quot;#attributes.fuseaction#&quot;</span>&gt;
		<span class="codecomment">&lt;cfcase value=<span class="codeattribute">&quot;hello&quot;</span>&gt;</span>
			<span class="codecomment"><span class="codecfpound">#<span class="function">displayView(<span class="functionattribute">&quot;hello.switchexample&quot;</span>)</span>#</span></span>
		<span class="codecomment">&lt;/cfcase&gt;</span>
		&lt;cfcase value=<span class="codeattribute">&quot;goodbye&quot;</span>&gt;
			&lt;cfinclude template=<span class="codeattribute">&quot;../../view/hello/goodbye.cfm&quot;</span> /&gt;
		&lt;/cfcase&gt;
		&lt;cfdefaultcase&gt;
			<span class="codehtml">&lt;p&gt;</span><span class="codecfpound">I am switch.#attributes.fuseaction#, and I don't exist.</span><span class="codehtml">&lt;/p&gt;</span>
		&lt;/cfdefaultcase&gt;
	&lt;/cfswitch&gt;
&lt;/cfoutput&gt;</span></pre>
<p>Look familiar? It might. It looks a lot like an old Fusebox 2/3 circuit. That's intentional. LightFront's designed to be a nice bridge between old Fusebox 2/3 application styles. It gives you new functionality, through callEvent() and displayView(), plus relocate() works a lot like &lt;cf_location&gt;.
<p>Notice how I was called via LightFront's displayView() function.</p>
<p>Now, <a href="#link('switch.goodbye')#">say goodbye</a>.</p>