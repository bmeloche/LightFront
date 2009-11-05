<cfoutput>
<cfif structKeyExists(request.attributes,"ID")>
	<h2>Edit Category ID: #request.attributes.id#</h2>
	<cfset id = request.attributes.id />
<cfelse>
	<cfset id = 0>
	<h2>Add New Category</h2>
</cfif>
<form method="post" action="./?do=admin.doEditCategory" name="categoryForm">
	<input type="hidden" name="categoryID" value="#ID#" />
	<!---<input type="hidden" name="do" value="" />--->
	<fieldset accesskey="f">
		<legend>Category</legend>
		<label>Category Name:</label>
		<input type="text" name="categoryName" id="categoryName" size="30" /><br />
		<label>Active</label>
		<input type="radio" name="categoryActive" id="categoryActive" value="1" />
		<label>Inactive</label>
		<input type="radio" name="categoryActive" id="categoryActive" value="0" /><br />
		<input type="submit" name="submit" value="Enter Category" id="submit" /> 
	</fieldset>
</form>
</cfoutput>