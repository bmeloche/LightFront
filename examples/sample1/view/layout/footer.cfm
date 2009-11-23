<cfif structKeyExists(request,"errorStruct") AND structKeyExists(request.errorStruct,"message")>
	<cfoutput>#request.errorStruct.message#</cfoutput>
</cfif>
</div>
<hr align="center" style="clear: both; margin: 0px;"/>
<div align="center">
	<div id="footer_right">
		<h6 id="footer_right_text" style="margin: 2px;">This site uses the LightFront Framework and is a part of the <a href="lightfront.zip">download</a>.</h6>
	</div>
	<div id="footer_left">
		<h4 id="footer_left_text" style="margin: 2px;"><cfoutput>LightFront Framework Version #application.lfront.settings.lightfrontVersion# is &copy;#year(now())# <a href="http://www.brianmeloche.com/">Brian Meloche</a> and is distributed under <a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a></cfoutput></h4>
	</div>
</div>
<hr align="center" style="clear: both; margin: 0px;"/>
<br />
</body></html>