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
			<a href="./?do=howto.howto">How To</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./?do=faq.faq">FAQ</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./?do=security.login">Call a View directly</a>
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
				&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="./?do=employee.overview">MVC CFC Controller Example</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
				<a href="./?do=switch.hello">Switch Controller Example</a>
			</cfif>
		</div>
		<div id="loginmenu">
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
				Welcome, #cookie.username# <a href="./?do=logout">Logout</a>
			<cfelse>
				<a href="./?do=login">Login</a>
			</cfif>
			(MVC Example)
		</div>
	</div>
</div>
<div id="content">
</cfoutput>
