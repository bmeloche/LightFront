<h2>How do I directly call views as actions?</h2>
<h4>And why would I?</h4>
<p>That's two questions! OK... First for the how...</p>
<h3>How do I directly call views as actions?</h3>
<p>Let's say you have a static page, or maybe it's a legacy page built on another framework (or none at all). You used to call this page as:</p>
<p>http://www.yoursite.com/home/contactus.cfm</p>
<ul>
	<li>Move that page to your view folder (as you defined in Application.cfc or the defaults from the framework if you didn't define it:<br/>
		/view/about/contactus.cfm</li>
	<li>Call the URL like this:<br />
		<a href="/?do=about.contactus">/?do=about.contactus</a> or <br />
		<a href="/index.cfm?do=about.contactus">/index.cfm?do=about.contactus</a>
	</li>
	<li>That's it! Simple enough for you?</li>
</ul>
<p><em>How about a more concrete example?</em> OK... let's take you through the anatomy of that view called as an action.</p>
<ul>
	<li>It first checks if there's an assignment (think alias) for that controller. If there is, it changes the requested controller for that assignment (more on this as the FAQs are filled out).</li>
	<li>If the controller exists for the requested controller:
		<ul>
			<li>LightFront tries to call the method requested (&quot;contactus&quot;, if there is one):
				<ul>
					<li>If the method does not exist, it'll throw an error.*</li>
					<li>If it exists, it calls application.lfront.ctrl.##componentname##.##methodname##().</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>If there was no assignment for the requested controller, and the controller does not exist:
		<ul>
			<li>It tries to call a view under the same name, which in our application example, would look at:<br />
				/views/about/contactus.cfm</li>
			<li>If it finds the requested view, it displays it. Try <a href="/?do=about.contactus">/?do=about.contactus</a> for an example.</li>
			<li>If it does not find the requested view, it throws an error message. An example here: <a href="/?do=about.aboutus">/?do=about.aboutus</a> (no /views/about/aboutus.cfm).</li>
		</ul>
	</li>
</ul>
<p><em>How about showing me how to do this...</em> Absolutely... it's easy... and should be intuitive!</p>
<ul>
	<li>Next, try adding a file called /views/about/aboutus.cfm. Add some HTML, such as:<br /><br />&lt;p&gt;I am the about us page, and I now exist.&lt;/p&gt;</li>
	<li>Once you add that file, try <a href="/?do=about.aboutus">/?do=about.aboutus</a> again.</li>
	<li>See... it's that easy!</li>
</ul>
<h4>So that's the how... now for the why.</h4>
<h3>Why would I directly call views as actions?</h3>
<p>ColdFusion is all about simplicity. LightFront is all about simplicity. Not every page we're going to want to show on your site will be dynamic. For pages that are largely static, directly calling your view as an action makes a lot of sense and it's a lot less hassle than in other frameworks.</p>
<p>Rather than the framework calling a controller calling a view, LightFront checks to see if there's a valid controller for that controller (&quot;about&quot;, in this example).</p>

<p>If you're migrating an existing site to LightFront, one that had no framework, this is another perfect use case for calling views directly.</p>
<p>Another application of this functionality would be for prototyping. You get all of the pages prototyped in LightFront and then call them in your model.</p>
<p>Mind you, you can always define actions any way you want to. There's nothing stopping you if you want to build a CFC method for that action, and I doubt there's nothing wrong with that going forward. You could also call a switch. The benefit of calling views directly means less coding time, less code to create actions, and a cleaner implementation. It's a pragmatic solution to </p>