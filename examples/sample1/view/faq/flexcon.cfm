<h2>Why does LightFront have &quot;Flexible Conventions&quot;? Why should I care?</h2>
<p>The concept behind flexible conventions is simple.</p>
<p>Typically, a CFML framework tackles concepts convention vs. configuration with one simple answer.</p>
<ul>
	<li>All configuration - Frameworks such as Mach-ii, Model-Glue and Fusebox do not provide a great degree of convention. Sure, there are certain ways those frameworks want you to configure your application, but you are given a great degree of freedom in how you do it.</li>
	<li>All convention - Frameworks such as FW/1, CF on Wheels and ColdBox offer a convention you must follow. While this does tend to make certain things easier, it is also a pain in the neck if you have to solve a problem in a way other than how the framework does it.</li>
</ul>
<p>That's where LightFront is different.</p>
<p>LightFront does not offer a great deal of configuration, but there are some things you must define. It was a conscious decision to define those values in Application.cfc.</p>
<p>I, personally, have spent a great deal of time developing applications on frameworks that offer a great deal of flexibility, through the use of a config file in XML. While this has its advantages, one major disadvantage is the lack of ability to configure actions dynamically. You also have to maintain an XML file.</p>
<p>It's always felt like the XML file has been an extra step. I wanted something simple.</p>
<h3>So, &quot;Flexible Conventions&quot;?</h3>
<p>Right... Flexible conventions give you the opportunity to define a few key settings in your application. If none has been defined, LightFront sets the value from its default.</p>
<p>For example, you can turn off switch based controllers altogether. You can change the default controller and view locations, as well as default actions, pre-actions and post-actions.</p>
<p>By giving you a little configuration, it makes it possible to &quot;set your own convention&quot;.</p>
<cfoutput>#displayView("faq.faq")#</cfoutput>