<cfset data = arguments.content />
<h2>MVC Examples - Returning Employee Data as Query</h2>
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
	<cfoutput query="data">
		<tr>
			<td align="center">#data.employeeID#</td>
			<td align="center">#data.userID#</td>
			<td align="center">#data.firstName#</td>
			<td align="center">#data.lastName#</td>
			<td align="center">#data.location#</td>
			<td align="center">#data.title#</td>
		</tr>
	</cfoutput>
</table>
<p>Here's what we see in /lfront/controller/employee.cfc:</p>
<pre>
<span class="code">&lt;cfset employeeService = <span class="function">initService(<span class="functionattribute">&quot;employee&quot;</span>)</span> /&gt;

&lt;cffunction name=<span class="codeattribute">&quot;query&quot;</span>&gt;
	&lt;cfset var employee = employeeService.<span class="function">getEmployeesAsQuery()</span> /&gt;
	&lt;cfreturn <span class="function">displayView(<span class="functionattribute">&quot;employee/query&quot;</span>,<span class="functionattribute">employee</span>)</span> /&gt;
&lt;/cffunction&gt;</span>
</pre>
<p>And here are the important parts that we have in /lfront/model/employeeService.cfc:</p>
<pre>
<span class="code">&lt;cfset employeeGateway = </span><span class="function">application.lfront.initComponent(</span><span class="functionattribute">&quot;employeeGateway&quot;</span><span class="function">,</span><span class="functionattribute">true</span><span class="function">)</span><span class="code"> /&gt;</span>
	...
<span class="code">&lt;cffunction name=</span><span class="codeattribute">&quot;getEmployeesAsQuery&quot;</span><span class="code"> access=</span><span class="codeattribute">&quot;public&quot;</span><span class="code"> returntype=</span><span class="codeattribute">&quot;query&quot;</span><span class="code"> hint=</span><span class="codeattribute">&quot;I get the employees.&quot;</span><span class="code">&gt;
	&lt;cfreturn </span><span class="function">employeeGateway.makeFakeEmployeeQueryData()</span><span class="code"> /&gt;
&lt;/cffunction&gt;</span></pre>
<p>And from this page (/view/employee/query.cfm):</p>
<pre>
<span class="code">&lt;cfset data = arguments.content /&gt;
...
&lt;cfoutput query=&quot;data&quot;&gt;
	<span class="codehtml">&lt;tr&gt;
		&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data.employeeID#</span>&lt;/td&gt;
		&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data.userID#</span>&lt;/td&gt;
		&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data.firstName#</span>&lt;/td&gt;
		&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data.lastName#</span>&lt;/td&gt;
		&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data.location#</span>&lt;/td&gt;
		&lt;td align=<span class="codeattribute">&quot;center&quot;</span>&gt;<span class="codecfpound">#data.title#</span>&lt;/td&gt;
	&lt;/tr&gt;</span>
&lt;/cfoutput&gt;</span>
</pre>