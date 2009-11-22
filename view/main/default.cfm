<!--- This next line is bad form. Queries should happen inside your model. It's here just to make the skeleton as small as possible. --->
<cfdirectory action="list" directory="#expandPath('/lf/examples/')#" name="files" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Home | LightFront Skeleton</title>
	<style type="text/css">
		html {
			width: 100%;
			margin: 0;
		}
		body {
			/*background-color: #FFF;*/
			background-color: #0084FF;
			margin: 0;
			padding: 0;
			font: 1em Arial, Helvetica, sans-serif; /* the font size in EM */
		}
		body #content {
			/*width: 900px;*/
			margin: 0;
			/*padding: 1em;*/
			background-color: #DDF;
		}
		body #header {
			background-color: #1D2855;
			/*margin: 0 auto;*/
			margin: 0 auto;
			width: 100%;
		}
		body #header table {
			font-size: 0.9em;
		}
		h1 {
			margin: 40px 0px 0px 10px;
		}
		h1 a {
			background-image: url(lightfront.gif);
			background-position: center left;
			background-repeat: no-repeat;
			margin-top: 30px;
			padding: 30px 0px 30px 110px;
			height: 100px;
			width: 400px;
			color: #000;
			text-decoration: none;
		}
		h1 a:hover {
			color: #000;
			text-decoration: underline;
		}
		hr {
			padding: 0;
			border: 0;
			color: #000;
			background-color: #CCC;
			height: 1px;
		}
		#googlegroup {
			border: 0px;
			background-color: #fff;
			padding: 5px;
			margin: 0px;
		}
		.googlegroupheader {
			padding-left: 5px;
			font-weight: bold;
		}
		.googlegroupcell {
			padding-left: 5px;
		}
		#content {
			background-color: #fff;
		}
	</style>
</head>
<cfoutput>
<body>
	<div id="header" align="center">
	<table width="920" bgcolor="##FFF" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td>
				<h1><a href="http://www.lightFront.org/">LightFront</a> Skeleton Page</h1>
				<br clear="all" />
			</td>
			<td width="200" nowrap="nowrap">
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
	<div style="background-color: ##0084FF; margin: 0;">
	<div id="success" style="width: 900px; margin: 0 auto; padding: 10px; background-color: ##E0E0FF">
	<p>You have successfully installed the LightFront framework!</p>
	<p>You may have gotten here by going to: <a href="http://#cgi.http_host##cgi.script_name#">http://#cgi.http_host##cgi.script_name#</a>. This event is <code>#getSetting("defaultEvent")#</code>.</p>
	<h3>So now what?</h3>
	<h4>Examples:</h4>
	<ul>
		<cfloop query="files">
			<cfif files.type is 'dir' and left(files.name,1) is not '.'>
				<li><a href="examples/#files.name#/">#files.name#</a></li>
			</cfif>
		</cfloop>
	</ul>
	<h4>Getting Started:</h4>
	<ul>
		<li>Open the Application.cfc file and change <code>this.name</code> to the name of your application, or keep the default, which will generate a unique one for you.</li>
		<li>Go to the setCustomLightFrontSettings() function and set LightFront's settings there. Don't worry, you only have to set the ones that are different than the defaults, or if your site will use optional settings, such as the use of switch files, as in Fusebox 2/3 circuits.</li>
		<li>If you want to keep your controller and view folders outside of the LightFront root, you can, but you need a mapping added to point them to /lf/controller and /lf/view/ respectively.</li>
		<li>Add your controller cfc(s).</li>
		<li>If you have views you want to call directly, add them according to the event you want to call.</li>
		<li>If you have Fusebox 2/3 circuits or similar switch file, you can add that as a controller as well.</li>
		<li>Add your model at your discretion.</li>
	</ul>
	<hr />
	<p align="center">LightFront Framework, version: #application.lfront.settings.lightfrontVersion#. &copy;#year(now())# <a href="http://www.brianmeloche.com/">Brian Meloche</a> -  - <a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a></p>
</div></div></div>
</body>
</cfoutput>
</html>