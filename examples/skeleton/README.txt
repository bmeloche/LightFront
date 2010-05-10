	Copyright (c) 2009, 2010 Brian Meloche

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

This version of LightFront is 0.4.4.

If you are reading this file from a LightFront application, it that means your installation of
LightFront didn't quite go as planned.

Installing LightFront

Assuming you are planning to build your first LightFront application, choose the examples/skeleton
as your starting point. There is a more verbose skeleton at examples/skeleton_verbose if you're setting 
a LightFront application for the first time.

If you want to see a sample application, choose examples/sample1.

We don't have full blown samples built yet, but that is on the horizon.

Here's the easiest installation - LightFront at the root of your website:

1) Unzip LightFront.zip to a folder on your computer. Don't unzip it to its
final destination. We're going to move only selected directories in.

2) Go to the examples folder. Copy the skeleton (or the skeleton_verbose) sample to your application
root. Example below (from the skeleton):

site root
	L-- controller
		L-- main.cfc (the default controller)
	L-- model
		L-- directory.cfc (a simple directory scanner, to show you where the model goes)
	L-- view
		L-- main
			L-- home.cfm (the default view)
	L-- assets (example... not a requirement)
		L-- css
		L-- js
		L-- images
	Application.cfc
	index.cfm
	lightfront.cfc (You don't need to put the LightFront CFC here. This example is good if you only have one LightFront site.
					Otherwise, you may want to create a mapping to point to it.)

3) Call up your website in the browser. You'll either want to surf LightFront as the root of a site, e.g.:

http://www.lightfront.test/
http://lightfront/
http://localhost/ or
http://localhost/lightfront/

Choose that first. If you want to try lightfront at the root of a site, set up any HOSTS file entries (if installing locally), virtual host
settings or websites if needed.

Once you have the correct URL, if a welcome page shows up, you're good to go!

Now what?

For developing LightFront applications, please check the LightFront wiki, located at:

http://lightfront.riaforge.org/wiki/