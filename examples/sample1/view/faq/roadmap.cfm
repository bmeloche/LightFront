<h2>What does the roadmap for LightFront look like?</h2>
<p>It's still early in LightFront's development, so this is subject to change, and will change depending on requests made. That said, as of November 23, 2009, only taking into account the lead developer's wishes, LightFront's current roadmap is as follows:
<ul>
	<li>0.4.1 - Current &quot;stable&quot; version</li>
	<li>0.4.2 - Development release, was combined with 0.4.3.
		<ul>
			<li>Renamed loadLightFrontRequest() to loadRequest().</li>
			<li>Renamed the /lf path to /lfront.</li>
			<li>Synchronized the naming conventions, so that functions removed any mention of LightFront. The exception is setCustomLightFrontSettings() and isLightFront() (which you may or may not need, and can be customized as you need it) in Application.cfc. This can change in 0.4.3 as well if people want it. It was thought to keep them explicitly named to make it obvious they were used in LightFront.</li>
			<li>Renamed variables used in functions to lfront. They were called lf, lfs and loc in various places.</li>
			<li>Corrected issue with the way 0.4.1 loaded services if you called one service from another.This was corrected with:</li>
			<li>initService() added - which allows you to either call the service from the application scope or create the service object and save it to the application scope.</li>
		</ul>
	</li>
	<li>0.4.3 - Currently in the 0.4.3 branch, but the core is stable and feature complete. Applications sample1 and sample2 not 100% compatible at the time of writing.
		<ul>
			<li>loadServices() deemed unnecessary, and was eliminated.</li>
			<li>callAction() added - will replace callEvent() in 0.4.4. Added for future compatibility. callEvent() is still available, but callAction() is recommended for future development.</li>
			<li>loadAction() added - allows you to save the callAction() to a variable in the request scope of your choosing.</li>
			<li>initComponent() added - allows you to call any component in the model, or elsewhere in your application.</li>
			<li>At request, the skeleton was stripped down to a minimum to remove any unneeded settings from Application.cfc.</li>
			<li>The skeleton application includes MVC functionality, with a directory service that returns data to the controller and is then accessed in the view. Many had questions on how LightFront interacts with the model, so this functionality was made more clear in the skeleton.</li>
			<li>The original skeleton was updated with the same functionality and renamed skeleton_verbose.</li>
			<li>The sample1 application is in the process of being updated to have better MVC examples. This is still in progress.</li>
			<li>The sample2 application will be updated as well.</li>
			<li>Updates to the FAQ, still in progress.</li>
			<li>Adding a roadmap (this page).</li>
			<li>Testing on CF8, Open BlueDragon 1.1+ and Railo 3.1+ not yet completed.</li>
		</ul>
	</li>
	<li>0.4.4 - The next planned release:
		<ul>
			<li>callEvent() deprecated; logic transferred to callAction().</li>
			<li>All references to events in LightFront will be renamed actions. This has been done because LightFront is NOT an event-driven implicit invocation framework, and this has been the source of confusion for some. LightFront is explicit, so actions are a more appropriate name.</li>
			<li>application.lfront.settings.applicationMode will be activated. It is currently a dummy field in 0.4.3 for reference and added for future compatibility. applicationMode will control whether a LightFront application can be initialized and whether the scopes can be dumped.</li>
			<li>Application.lfront.settings.defaultPage &amp; application.lfront.settings.viewExtension will be used in tandem in the Application.cfc. viewExtension is not currently used in Application.cfc, only in displayView().</li>
			<li>Updates of the existing applications to support the change.</li>
			<li>Updates to the FAQ.</li>
		</ul>
	</li>
	<li>0.4.5 - Another round of improvements:
		<ul>
			<li>Addition of a preAction and a postAction that can be executed for each CFC controller. Instead of calling the method directly, LightFront will allow you to run a preAction per CFC class. Currently, a preAction/preEvent must be set for the entire application. Currently, the only way you can do this is if you use a switch-based controller to handle preAction and postActions.</li>
			<li>New example application: one that uses Application.cfm instead of Application.cfc, to better support legacy applications.</li>
			<li>New example application: one that shows you using LightFront with an existing application.</li>
		</ul>
	</li>
	<li>0.4.6 - Maintenance release:
		<ul>
			<li>Update FAQs to catch up with the current version.</li>
			<li>Any updates/fixes as needed.</li>
			<li>Requests also considered.</li>
		</ul>
	</li>
	<li>0.4.x - Other updates to 0.4 as needed.</li>
	<li>0.5.x - Last alpha release:
	<ul>
		<li>callEvent() will be removed from the framework.</li>
		<li>Convert an existing Fusebox 2 application to LightFront, making any changes to the framework and the application that are needed.</li>
		<li>Improvements to sample applications, as needed.</li>
		<li>Full documentation outline begun, with content ported from FAQ as needed.</li>
		<li>Documentation will try to establish best practices on how to do common tasks in LightFront, while not forcing you to use those practices.</li>
		<li>Getting started videos added.</li>
		<li>Convert a Fusebox 3-era application to LightFront, making any changes to the framework as needed for Fusebox 3 compatibility.</li>
		<li>Write a LightFront port of LitePost.</li>
		<li>Basic www.lightfront.org made available.</li>
		<li>Last version of 0.5 will be considered the &quot;stable&quot;  release before the next round of enhancements are added (may consider a version change at this point to 1.0, depending on LightFront community's opinion at that time).</li>
	</ul>
	</li>
	<li>0.6.x - Beta 1 release:
		<ul>
			<li>Initial LightFront plugin architecture released - This functionality will allow you to develop plugins to LightFront, extending its functionality. Note: The intent here is to keep the LightFront core small, but to allow you to extend it with optional plugins. This plugin architecture could be added via custom tags, via functions similar to initService() and initComponent() or both.</li>
			<li>Plugin sample developed to tie LightFront into <a href="http://www.getmura.com">MuraCMS</a>.</li>
			<li>ColdSpring Plugin added (ColdSpring can be used now; this would add a plugin to make it simpler) for developers to implement.</li>
			<li>Documentation opened to community through wiki</li>
			<li>Basic documentation released</li>
			<li>www.lightfront.org developed and released, written in a LightFront/MuraCMS architecture.</li>
			<li>New functionality, as requested.</li>
			<li>New samples, as requested/needed.</li>
			<li>Last additions to the core before 1.0 released.</li>
		</ul>
	</li>
	<li>0.7.x - Beta 2 release:
		<ul>
			<li>Release the lightfront.org code to open source.</li>
			<li>Implement more getting started videos.</li>
			<li>Refinements to the LightFront plugin architecture released.</li>
			<li>Plugins, both developed by the LightFront team and independent of the core, added. Existing plugins enhanced.</li>
			<li>Add an experimental script only lightfront.cfc and Application.cfc for CF9 (and other CFML engines that support it by that time).</li>
			<li>Refinements to documentation.</li>
			<li>Refinements to the core, as needed.</li>
		</ul>
	</li>
	<li>0.8.x - Beta 3 release:
		<ul>
			<li>Add a plugin &quot;marketplace&quot; to lightfront.org to allow developers to offer open source, free and paid plugins.</li>
			<li>Refinements and additions needed to documentation, training videos</li>
			<li>Refinements to the core, as needed.</li>
			<li>Others as needed.</li>
		</ul>
	</li>
	<li>0.9.x - Release candidates
		<ul>
			<li>Refinements as needed, for stability.</li>
			<li>Finalized documentation, videos, etc.</li>
		</ul>
	</li>
	<li>1.0 - Full release!
		<ul>
			<li>Version 1.0 of LightFront should remain just about as easy to learn and use as it does now, with optional plugins giving you more power and robustness, as well as full documentation.</li>
			<li>If the last alpha 0.5 becomes the first 1.0, this version 1.0 will be known as version 2.0.</li>
		</ul>
	</li>
	<li>1.1 - Let's hope we get there!</li>
</ul>
</p>