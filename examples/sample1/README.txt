	Copyright (c) 2009, Brian Meloche

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

This version of LightFront is 0.4.3.

If you are reading this file from a LightFront application, it that means your installation of
LightFront didn't quite go as planned.

Installing LightFront

Assuming you are planning to build your first LightFront application, choose the examples/skeleton
as your starting point. There is a more verbose skeleton at examples/skeleton_verbose if you're setting 
up a LightFront application for the first time.

If you want to see a sample application, choose examples/sample1.

We don't have full blown samples built yet, but that is on the horizon.

Here's the easiest installation - LightFront at the root of your website:

1) Unzip LightFront.zip to a folder on your computer. Don't unzip it to its
final destination. We're going to move only selected directories in.

2) Go to the examples folder. Copy the skeleton folder your application
root. Example below:

webroot
	L-- controller
	L-- model
	L-- view
	L-- assets (example... not a requirement)
		L-- css
		L-- javascript
		L-- images
	Application.cfc
	index.cfm

3) Copy the /org/lightfront folder at the root of your web server, or create a mapping to its location.

Continuing the previous example:

webroot
	L-- org
		L-- lightfront
			-- lightfront.cfc
	L-- model
	L-- controller
	L-- view
	L-- assets
		L-- css
		L-- javascript
		L-- images
	-- Application.cfc
	-- index.cfm

4) Call up your website in the browser.

You'll either want to surf LightFront as the root of a site
(e.g. http://www.lightfront.test/, http://lightfront/, http://localhost/ or
http://localhost/lightfront/). Choose that first. If you want to try lightfront
at the root of a site, set up any HOSTS file entries (if installing locally), virtual host
settings or websites if needed.

NOTE: Because you are extending Application.cfc, you can't define the org/lightfront mapping in your Application.cfc.

5) Place your controller and view folder at either one down from your site root, under your application
folder or other locations of your choice.

6) In Application.cfc, map /lfront to the root (where your Application.cfc is located. If you are using ColdFusion MX 7,
add a mapping in CFAdministrator to lfront at the root of your application.

7) If you choose different locations for the model, view and controller directories, add mappings to /lfront/model,
/lfront/controller and /lfront/view in your Application.cfc or Administrator.

8) Access your site! If you get a LightFront hello world, you are set up and ready to go! This skeleton application shows a
basic MVC pattern, with a model (a service), view and controller.

9) Check the /examples directory for more sample applications!
