<h2>Employee Section</h2>
<p>Here are some MVC examples:</p>
<h3>Do a query of employees, return as:</h3>
<cfoutput>
	<ul>
		<li><a href="#link('home.employee')#">Retrieve a Single Employee</a></li>
		<li><a href="#link('employee.query')#">Query</a></li>
		<li><a href="#link('employee.array')#">Array of Structures</a></li>
		<li><a href="#link('employee.objects')#">Array of Objects</a></li>
	</ul>
</cfoutput>