<cfset files = arguments.content />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Home | LightFront Skeleton</title>
	<link rel="stylesheet" href="./assets/css/styles.css" type="text/css" media="all" />
</head>
<cfoutput>
<body>
	<div id="header" align="center">
		<table width="920" bgcolor="##FFF" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td width="670">
					<h1><a href="http://www.lightFront.org/">LightFront</a> Skeleton Page</h1>
					<br clear="all" />
				</td>
				<td width="250" nowrap="nowrap">
					<form action="http://groups.google.com/group/lightfront/boxsubscribe">
						<table id="googlegroup">
							<tr>
								<td align="right"><img src="http://groups.google.com/intl/en/images/logos/groups_logo_sm.gif" height="30" width="140" alt="LightFront Google Group" /></td>
							</tr>
							<tr>
								<td align="right" class="googlegroupheader"><strong>Subscribe to LightFront</strong></td>
							</tr>
							<tr>
								<td align="right" class="googlegroupcell">Email: <input type="text" name="email" /></td>
							</tr>
							<tr>
								<td align="right">
									<input type="submit" name="sub" value="Subscribe" /> <a href="http://groups.google.com/group/lightfront">Visit this group</a>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
		</table>
	</div>
	<div id="content">
		<div id="main">
			<div id="success">
				<p>You have successfully installed the LightFront framework!</p>
				<p>You may have gotten here by going to: <a href="http://#cgi.http_host##cgi.script_name#">http://#cgi.http_host##cgi.script_name#</a>. This action is <code>#getSetting("defaultAction")#</code>.</p>
				<h3>So now what?</h3>
				<h4>Examples:</h4>
				<ul>
					<cfloop query="files">
						<cfif files.type is 'dir' and left(files.name,1) NEQ '.'>
							<li><a href="../#files.name#/">#files.name#</a></li>
						</cfif>
					</cfloop>
				</ul>
				<h4>Getting Started:</h4>
				<ul>
					<li>Open the Application.cfc file and change <code>this.name</code> to the name of your application, or keep the default, which will generate a unique one for you.</li>
					<li>Go to the setCustomLightFrontSettings() function and set LightFront's settings there that aren't part of the standard install. Don't worry, you only have to set the ones that are different than the defaults, or if your site will use optional settings, such as the use of switch files, as in Fusebox 2/3 circuits.</li>
					<li>If you want to keep your controller and view folders outside of the LightFront root, you can, but you need a mapping added to point them to /lfront/controller/ and /lfront/view/ respectively.</li>
					<li>Add your controller cfc(s).</li>
					<li>If you have views you want to call directly, add them according to the action you want to call.</li>
					<li>If you have Fusebox 2/3 circuits or a similar switch file, you can add that as a controller as well. In order for those to work, you must declare a setting in setCustomLightFrontSettings() of your Application.cfc.</li>
					<li>LightFront can automatically read services located in /lfront/model/ by calling initService(serviceName).</li>
					<li>You can declare other CFCs in the model using application.lfront.initComponent(path within /lfront/model), use a custom object factory or a dependency injection framework like ColdSpring or LightWire.</li>
				</ul>
				<hr />
				<p align="center">LightFront Framework, version: #application.lfront.settings.lightfrontVersion#. &copy;#year(now())# <a href="http://www.brianmeloche.com/">Brian Meloche</a> - <a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a></p>
			</div>
		</div>
	</div>
</body>
</cfoutput>
</html>