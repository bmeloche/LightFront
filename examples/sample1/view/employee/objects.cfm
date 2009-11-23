<cfset data = arguments.content />
<h2>MVC Examples - Returning Employee Data as an Array of Objects</h2>
<cfoutput>#displayView("employee/menu")#</cfoutput>
<table width="80%" border="0" cellspacing="5" cellpadding="5">
	<tr>
		<th>EMPLOYEE ID</th>
		<th>USER ID</th>
		<th>FIRST NAME</th>
		<th>LAST NAME</th>
		<th>LOCATION</th>
		<th>TITLE</th>
	</tr>
	<cfoutput>
		<cfloop from="1" to="#arrayLen(data)#" index="i">
			<tr>
				<td align="center">#data[i].getEmployeeID()#</td>
				<td align="center">#data[i].getUserID()#</td>
				<td align="center">#data[i].getFirstName()#</td>
				<td align="center">#data[i].getLastName()#</td>
				<td align="center">#data[i].getLocation()#</td>
				<td align="center">#data[i].getTitle()#</td>
			</tr>
		</cfloop>
	</cfoutput>
</table>
<p>Here's what we see in /lfront/controller/employee.cfc:</p>
<pre>
<span class="code">&lt;cfset employeeService = <span class="function">initService(<span class="functionattribute">&quot;employee&quot;</span>)</span> /&gt;

&lt;cffunction name=<span class="codeattribute">&quot;objects&quot;</span>&gt;
	&lt;cfset var employee = employeeService.<span class="function">getEmployees()</span> /&gt;
	&lt;cfreturn <span class="function">displayView(<span class="functionattribute">&quot;employee/objects&quot;</span>,<span class="functionattribute">employee</span>)</span> /&gt;
&lt;/cffunction&gt;</span>
</pre>
<p>And here are the important parts that we have in /lfront/model/employeeService.cfc:</p>
<pre>
<span class="code">&lt;cfset employeeGateway = </span><span class="function">application.lfront.initComponent(</span><span class="functionattribute">&quot;employeeGateway&quot;</span><span class="function">,</span><span class="functionattribute">true</span><span class="function">)</span><span class="code"> /&gt;</span>
	...
<span class="code">&lt;cffunction name=<span class="codeattribute">&quot;getEmployees&quot;</span> access=<span class="codeattribute">&quot;public&quot;</span> returntype=<span class="codeattribute">&quot;array&quot;</span> hint=<span class="codeattribute">&quot;I get the employees as an array of objects.&quot;</span>&gt;
	&lt;cfset var qList = <span class="function">getEmployeesAsArray()</span> /&gt;
	&lt;cfreturn <span class="function">makeArrays(</span><span class="functionattribute">qList</span><span class="function">)</span>/&gt;
&lt;/cffunction&gt;

&lt;cffunction name=<span class="codeattribute">&quot;makeArrays&quot;</span> access=<span class="codeattribute">&quot;public&quot;</span> returntype=<span class="codeattribute">&quot;array&quot;</span> hint=<span class="codeattribute">&quot;I get an array of employees and return an array of objects.&quot;</span>&gt;
	&lt;cfargument name=<span class="codeattribute">&quot;tmpArray&quot;</span> type=<span class="codeattribute">&quot;array&quot;</span> /&gt;
	&lt;cfset var arrObjects = <span class="function">arrayNew(<span class="functionattribute">1</span>)</span> /&gt;
	&lt;cfset var tmpObj = <span class="codeattribute">&quot;&quot;</span> /&gt;
	&lt;cfset var i = <span class="codeattribute">0</span> /&gt;
	&lt;cfloop from=<span class="codeattribute">&quot;1&quot;</span> to=<span class="codeattribute">&quot;#<span class="function">arrayLen(<span class="functionattribute">arguments.tmpArray</span>)</span>#&quot;</span> index=<span class="codeattribute">&quot;i&quot;</span>&gt;
		&lt;cfset tmpObj = <span class="function">createObject(<span class="functionattribute">&quot;component&quot;</span>,<span class="functionattribute">&quot;employee&quot;</span>).init(<span class="functionattribute">argumentCollection=arguments.tmpArray</span><span class="function">[i]</span>)</span> /&gt;
		&lt;cfset <span class="function">arrayAppend(<span class="functionattribute">arrObjects</span>,<span class="functionattribute">tmpObj</span>)</span> /&gt;
	&lt;/cfloop&gt;
	&lt;cfreturn arrObjects /&gt;
&lt;/cffunction&gt;</span></pre>
<p>And from this page (/view/employee/objects.cfm):</p>
<pre>
<span class="code">&lt;cfset data = arguments.content /&gt;
...
&lt;cfoutput&gt;
	&lt;cfloop from=<span class="codeattribute">&quot;1&quot;</span> to=<span class="codeattribute">#arrayLen(data)#"</span> index=<span class="codeattribute">&quot;i&quot;</span>&gt;
		<span class="codehtml">&lt;tr&gt;
			&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data[i].getEmployeeID()#</span>&lt;/td&gt;
			&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data[i].getUserID()#</span>&lt;/td&gt;
			&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data[i].getFirstName()#</span>&lt;/td&gt;
			&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data[i].getLastName()#</span>&lt;/td&gt;
			&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data[i].getLocation()#</span>&lt;/td&gt;
			&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data[i].getTitle()#</span>&lt;/td&gt;
		&lt;/tr&gt;</span>
	&lt;/cfloop&gt;
&lt;/cfoutput&gt;</span>
</pre>

<cfoutput>#displayView("employee/menu")#</cfoutput>