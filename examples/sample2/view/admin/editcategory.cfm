<cfoutput>
	<cfif structKeyExists(request.attributes,"ID")>
		<h2>Edit Category ID: #request.attributes.id#</h2>
		<cfset id = request.attributes.id />
	<cfelse>
		<cfset id = 0>
		<h2>Add New Category</h2>
	</cfif>
	<cfset selected = "" />
	<form method="post" action="#link('admin.doEditCategory')#" name="categoryForm">
		<input type="hidden" name="categoryID" value="#arguments.content.category.getcategoryID()#" />
		<fieldset accesskey="f">
			<legend>Category</legend>
			<label>Category Name:</label>
			<input type="text" name="categoryName" id="categoryName" size="30" value="#arguments.content.category.getcategoryname()#" /><br />
			<label>Active</label>
			<cfif arguments.content.category.getCategoryStatus() EQ 1>
				<cfset selected = 'checked="checked"'>
			</cfif>
			<input type="radio" name="categoryStatus" id="categoryStatus" value="1" #selected# />
			<label>Inactive</label>
			<cfif arguments.content.category.getCategoryStatus() EQ 0>
				<cfset selected = 'checked="checked"'>
			<cfelse>
				<cfset selected = "">
			</cfif>
			<input type="radio" name="categoryStatus" id="categoryStatus" value="0" #selected# /><br />
			<input type="submit" name="submit" value="Enter Category" id="submit" />
		</fieldset>
	</form>
</cfoutput>