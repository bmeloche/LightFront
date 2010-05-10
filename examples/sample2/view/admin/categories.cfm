<h2>Category Admin</h2>
<h3>Current Categories:</h3>
<table>
	<tr>
		<th>#</th>
		<th>Category Name</th>
		<th>Status</th>
	</tr>
<cfif arrayLen(arguments.content.categoryList) EQ 0>
	<tr>
		<td colspan="2">No categories found.</td>
	</tr>
<cfelse>
	<cfoutput>
		<cfloop from="1" to="#arrayLen(arguments.content.categoryList)#" index="i">
		<tr>
			<td><a href="#link('admin.editcategory')#&id=#arguments.content.categoryList[i].getCategoryID()#">#arguments.content.categoryList[i].getCategoryID()#</a></td>
			<td>#arguments.content.categoryList[i].getCategoryName()#</td>
			<td>#iif(arguments.content.categoryList[i].getCategoryStatus() EQ 1,DE("Active"),DE("Inactive"))#</td>
		</tr>
		</cfloop>
	</cfoutput>
</cfif>
</table>
<p><cfoutput><a href="#link('admin.editcategory')#">Add New Category</a></cfoutput></p>
