<h2>initComponent()</h2>
<p>Like initService, initComponent is used to call other CFCs in your model. It allows services to easily call up DAOs, gateways, other services and other CFCs, and it can also be used by controllers to call other CFCs outside of the model. Also like initService, initComponent  stored elsewhere and/or initialize a service CFC in the model, whether that object is in the application scope or not.</p>
<p>It works like this: If you call initService("category"), it will first check to see if there is already an application.lfront.service["category"]. If yes, it returns that object. If no, it creates one and returns it.</p>
<p>InitService is designed to provide a basic object factory. LightFront does not require you to use initService() for your model, but it is a small, lightweight way to do so.</p>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="5">initComponent(componentName, useModelRoot, load)</th>
	</tr>
	<tr valign="top">
		<th>Argument</th>
		<th>Type</th>
		<th>Required?</th>
		<th>Default</th>
		<th>Description</th>
	</tr>
	<tr valign="top">
		<td>componentName</td>
		<td>string</td>
		<td>Required</td>
		<td>N/A</td>
		<td>
			The name of the component you want to call.<br />
			e.g. initComponent("categoryDAO")
		</td>
	</tr>
	<tr valign="top">
		<td>useModelRoot</td>
		<td>boolean</td>
		<td>Required</td>
		<td>true</td>
		<td>If true, look in the modelRoot. If set to true, you can concatenate the component name, leaving out the modelRoot.<br />
			If 
		</td>
	</tr>
	<tr valign="top">
		<td>load</td>
		<td>boolean</td>
		<td>Required</td>
		<td>true</td>
		<td>If true, create the object and save it to the application.lfront.model scope, if it wasn't already defined there.<br />
			If false, create the object only. Do not save it to the application scope.<br />
			Returns the object.
		</td>
	</tr>
</table>