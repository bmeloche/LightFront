<h2>What is LightFront?</h2>
<p>LightFront stands for Lightweight Front-end controller.</p>
<p>LightFront is designed to be an extremely lightweight controller when compared to some of CFML's major frameworks, such as <a href="http://www.mach-ii.com">Mach-ii</a>, <a href="http://www.model-glue.com">Model Glue</a>, <a href="http://www.fusebox.org">Fusebox/FuseNG</a> and <a href="http://www.coldboxframework.com">ColdBox</a>.</p>
<p>It is similar in some ways and very different in others to <a href="http://www.corfield.org/blog/">Sean Corfield's</a> recently created <a href="http://fw1.riaforge.org">FW1</a> framework.</p>
<p>LightFront is designed to be light in setup. There is no XML controller/config file, such as Mach-ii, Model Glue and the XML-based Fusebox have (no-XML Fusebox is similar to LightFront, although heavier). Instead, you set your configs in Application.cfc. The framework has defaults, so only set the ones you need.</p>
<cfoutput>#displayView("faq.faq")#</cfoutput>