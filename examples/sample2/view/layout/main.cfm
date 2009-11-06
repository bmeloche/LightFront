<cfoutput>
<html>
	<head>
		<title>The LightFront Framework - Sample 2</title>
		<link rel="stylesheet" href="./assets/css/style.css" />
	</head>
<body>
<div id="header">
	<h1>The LightFront Framework - Sample 2 - Basic Site w/MVC</h1>
	<div id="navbar">
		<div id="menu">
			<a href="./#settings.defaultPage#">Home</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./#settings.defaultPage#?do=main.about">About Us</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./#settings.defaultPage#?do=main.staff">Staff</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./#settings.defaultPage#?do=main.contact">Contact Us</a>
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
					&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="./#settings.defaultPage#?do=admin.welcome">Admin</a>
			</cfif>
		</div>
		<div id="loginmenu">
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
				Welcome, #cookie.username# <a href="./?do=logout">Logout</a>
			<cfelse>
				<a href="./#settings.defaultPage#?do=security.login">Login</a>
			</cfif>
		</div>
		<div style="clear: both;"></div>
	</div>
</div>
<div id="content">
	<cfif structKeyExists(request,"eventResult")>#request.eventResult#</cfif>
	<cfif structKeyExists(request,"errorStruct")><cfdump var="#request.errorStruct#" label="LightFront Error"></cfif>
</div>
<hr align="center" style="clear: both; margin: 0px;"/>
<div align="center">
	<div id="footer_right">
		<h6 id="footer_right_text" style="margin: 2px;">This site uses the LightFront Framework and is a part of the <a href="lightfront.zip">download</a>.</h6>
	</div>
	<div id="footer_left" style="width: auto; float: left; margin: 5px;">
		<h4 id="footer_left_text" style="margin: 2px;">LightFront Framework Version #application.lfront.settings.lightfrontVersion# is &copy;#year(now())# <a href="http://www.brianmeloche.com/">Brian Meloche</a> and is distributed under <a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a></h4>
	</div>
</div>
<hr align="center" style="clear: both; margin: 0px;"/>
<br />
</body></html></cfoutput>