<h2>How do you call the model from LightFront?</h2>
<p>Essentially, you can interact with the model in a way that works for you. If you use a dependency injection framework like ColdSpring or LightWire, there's nothing stopping you from doing that. If you've built your own factory, you can keep using it in LightFront.</p>
<p>HOWEVER, if you are not already using an object factory or dependency injection framework of your own, you can use two simple LightFront functions specifically designed to work with the model:</p>
<ul>
	<li><a href="#link('howto._initservice')#">initService()</a> - allows you to inject the service you need into both controllers and other services.</li>
	<li><a href="#link('howto._initcomponent')#">initComponent()</a> - allows you inject other CFCs that are not services in your model, whether they are within your model or are other CFCs located elsewhere in your system, such as utility CFCs, plugins, or pretty much anything you would want to initialize within another CFC. initComponent() was designed to call DAOs, gateways and value objects (also known as data transfer objects, not to be confused with the <a href="http://www.transfer-orm.com">Transfer ORM</a> framework.</li>
</ul>
<p>Both initService() and initComponent() work in a similar way.</p>
<p>initService() allows </p>