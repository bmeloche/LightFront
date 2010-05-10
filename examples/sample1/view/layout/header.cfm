<cfoutput>
<html>
	<head>
		<title>The LightFront Framework</title>
		<link rel="stylesheet" href="./assets/css/style.css" />
	</head>
<body>
<div id="header">
	<div id="headertable">
		<div style="float: left;"><a href="http://www.lightfront.org/"><img src="assets/images/lightfront.gif" align="middle" border="0" alt="The LightFront logo" /></a></div>
		<div style="float: left;"><h1><a href="http://www.lightfront.org/">The LightFront Framework</a></h1></div>
	</div>
	<div id="navbar">
		<div id="menu">
			<a href="#link(getSetting('defaultAction'))#">Home</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="#link('faq.faq')#">FAQ</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="#link('home.welcome')#">Welcome</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="#link('home.hello')#">Hello</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="#link('switch.hello')#">Switch Controllers</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="#link('security.login')#">Call a View directly (login page)</a>
		</div>
		<div id="loginmenu">
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
				Welcome, #cookie.username# <a href="#link('logout')#">Logout</a>
			<cfelse>
				<a href="#link('login')#">Login</a>
			</cfif>
		</div>
	</div>
</div>
<div id="content">
</cfoutput>
