<h2>initService()</h2>
<p>InitService is used to call service CFCs in your model. It allows controllers to easily call up and/or initialize a service CFC in the model, whether that object is in the application scope or not.</p>
<p>It works like this: If you call initService("category"), it will first check to see if there is already an application.lfront.service["category"]. If yes, it returns that object. If no, it creates one and returns it.</p>
<p>InitService is designed to provide a basic object factory. LightFront does not require you to use initService() for your model, but it is a small, lightweight way to do so.</p>
<p>InitService expects the service to be within the defined serviceRoot.</p>
<table border="1" cellpadding="5">
	<tr>
		<th colspan="5">initService(serviceName,load)</th>
	</tr>
	<tr valign="top">
		<th>Argument</th>
		<th>Type</th>
		<th>Required?</th>
		<th>Default</th>
		<th>Description</th>
	</tr>
	<tr valign="top">
		<td>serviceName</td>
		<td>string</td>
		<td>Required</td>
		<td>N/A</td>
		<td>
			The name of the service you want to call.<br />
			e.g. initService("security")
		</td>
	</tr>
	<tr valign="top">
		<td>load</td>
		<td>boolean</td>
		<td>Required</td>
		<td>true</td>
		<td>If true, create the service object and save it to the application scope, if it wasn't already defined there.<br />
			If false, create the service object only. Do not save it to the application scope.<br />
			Returns the service object.
		</td>
	</tr>
</table>