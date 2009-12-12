<cfoutput>
<html>
	<head>
		<title>The LightFront Framework</title>
		<link rel="stylesheet" href="./assets/css/style.css" />
	</head>
<body>
<div id="header">
	<h1>The LightFront Framework</h1>
	<div id="navbar">
		<div id="menu">
			<a href="#getSetting('defaultPage')#">Home</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="#link('howto.howto')#">How To</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="#link('faq.faq')#">FAQ</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="#link('security.login')#">Call a View directly</a>
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
				&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#link('employee.overview')#">MVC CFC Controller Example</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
				<a href="#link('switch.hello')#">Switch Controller Example</a>
			</cfif>
		</div>
		<div id="loginmenu">
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
				Welcome, #cookie.username# <a href="#link('logout')#">Logout</a>
			<cfelse>
				<a href="#link('login')#">Login</a>
			</cfif>
			(MVC Example)
		</div>
	</div>
</div>
<div id="content">
</cfoutput>
