<cfoutput>
<html>
	<head>
		<title>LightFront - Sample 2</title>
		<link rel="stylesheet" href="/assets/css/style.css" />
	</head>
<body>
<div id="header">
	<h1>Sample 2 - Basic Site w/MVC</h1>
	<div id="navbar">
		<div id="menu" style="float: left;">
			<a href="./#settings.defaultPage#">Home</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./#settings.defaultPage#?do=main.about">About Us</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./#settings.defaultPage#?do=main.staff">Staff</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./#settings.defaultPage#?do=main.contact">Contact Us</a>
		</div>
		<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
			<div id="adminmenu" style="float: left;">
				&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="./#settings.defaultPage#?do=admin.welcome">Admin</a>
			</div>
		</cfif>
		<div id="loginmenu" style="float: right;">
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
				Welcome, #cookie.username# <a href="./?do=logout">Logout</a>
			<cfelse>
				<a href="./#settings.defaultPage#?do=security.login">Login</a>
			</cfif>
		</div>
		<div style="clear: both;"></div>
	</div>
</div>
<div id="content">#request.eventResult#</div>
<hr align="center" style="clear: both; margin: 0px;"/>
<div align="center">
	<div id="footer_right" style="width: 250px; float: right; margin: 5px; vertical-align: text-top;">
		<h6 id="footer_right_text" style="margin: 2px;">This site uses the LightFront Framework and is a part of the <a href="lightfront.zip">download</a>.</h6>
	</div>
	<div id="footer_left" style="width: auto; float: left; margin: 5px;">
		<h4 id="footer_left_text" style="margin: 2px;">LightFront Framework Version #application.lfront.settings.lightfrontVersion# is &copy;#year(now())# <a href="http://www.brianmeloche.com/">Brian Meloche</a> and is distributed under <a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a></h4>
	</div>
</div>
<hr align="center" style="clear: both; margin: 0px;"/>
<br />
</body></html></cfoutput>