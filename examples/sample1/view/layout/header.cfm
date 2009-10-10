<cfoutput>
<html>
	<head>
		<title>The LightFront Framework</title>
		<link rel="stylesheet" href="assets/css/style.css" />
	</head>
<body>
<div id="header">
	<h1>The LightFront Framework</h1>
	<div id="nav">
		<div id="menu">
			<a href="./?">Home</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./?do=faq.faq">FAQ</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./?do=home.welcome">Welcome</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./?do=home.hello">Hello</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./?do=switch.hello">Switch Controllers</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="./?do=security.login">Call a View directly (login page)</a>
		</div>
		<div id="loginmenu">
			<cfif isDefined("cookie") AND structKeyExists(cookie,"username")>
				Welcome, #cookie.username# <a href="./?do=logout">Logout</a>
			<cfelse>
				<a href="./?do=login">Login</a>
			</cfif>
		</div>
	</div>
</div>
<div id="content">
</cfoutput>
