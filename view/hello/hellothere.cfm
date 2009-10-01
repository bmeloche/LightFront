<h2>Hello! I am ./view/home/hello/hellothere.cfm!</h2>
<cfif request.attributes.do IS "home.hello">
	<h3>I was called as displayView("home/hello/hellothere")</h3>
	<p>I can also be called <a href="./?do=home.hellovariant">this way</a>.</p>
<cfelse>
	<h3>I was called as displayView("home.hello.hellothere"), if "." is the event delimiter.</h3>
	<p>I can also be called <a href="./?do=home.hello">this way.</a></p>
</cfif>
