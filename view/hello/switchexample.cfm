<p>I am ./view/home/switch.cfm. I was called from ./controller/switch/switch.cfm.</p>
<p>Here's what the switch looks like:</p>
<cffile action="read" file="#expandPath('./controller/switch/switch.cfm')#" variable="foo" />
<cfoutput><pre>#htmlEditFormat(foo)#</pre></cfoutput>
<p>Look familiar? It might. It looks a lot like an old Fusebox 2/3 circuit. That's intentional. LightFront's designed to be a nice bridge between old Fusebox 2/3 application styles. It gives you new functionality, through callEvent() and displayView(), plus relocate() works a lot like &lt;cf_location&gt;.
<p>Notice how I was called via LightFront's displayView() function.</p>
<p>Now, <a href="./?do=switch.goodbye">say goodbye</a>.</p>