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

Installing LightFront

Assuming you are planning to build your first LightFront application, choose the examples/skeleton
as your starting point.

If you want to see a sample application, choose examples/sample1.

We don't have full blown samples built yet, but that is on the horizon.

Here's the easiest installation - LightFront at the root of your website:

1) Choose skeleton or sample1. Unzip that to your site root. Example below.

webroot
	L-- controller
	L-- view
	L-- assets (example... not a requirement)
		L-- css
		L-- javascript
		L-- images
	Application.cfc
	index.cfm

2) Put the /org/lightfront folder at the root of your web server, or create a mapping to its location.

Continuing the previous example:

webroot
	L-- org
		L-- lightfront
			-- lightfront.cfc
	L-- controller
	L-- view
	L-- assets
		L-- css
		L-- javascript
		L-- images
	-- Application.cfc
	-- index.cfm

3) Call up your website in the browser.

You'll either want to surf LightFront as the root of a site (e.g. http://www.lightfront.test/,
http://lightfront/, http://localhost/ or http://localhost/lightfront/). Choose that first. If you want to
try lightfront at the root of a site, set up any HOSTS file entries (if installing locally), virtual host
settings or websites if needed.




NOTE: Because you are extending Application.cfc, you can't define org/lightfront in your Application.cfc.


3) Place your controller and view folder at either one down from your site root, under your application
folder or other locations of your choice.

4) In Application.cfc, map /lf/controller and /lf/view to the controller and view locations.

5) Access