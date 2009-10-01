<p>I am ./view/hello/goodbye.cfm, and I am called from a conventional Fusebox 2/3 style switch via an include, as shown here:</p>
<cffile action="read" file="#expandPath('./controller/switch/switch.cfm')#" variable="foo" />
<cfoutput><pre>#htmlEditFormat(foo)#</pre></cfoutput>
<p>I am a good example of how LightFront can use a legacy application and even let you add to it. It respects this as the switch circuit.</p>
<p>Now, <a href="./?do=switch.solong">say so long</a>! This will give you a friendly error message.</p>
<p>What if in your old Fusebox application you don't use &quot;do&quot;? No problem. Check setSettingsForLightFront() in Application.cfc and change local.eventVariable to the variable name you need.</p>