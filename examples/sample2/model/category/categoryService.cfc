<cfcomponent displayname="categoryService" output="false">

	<!--- Init category --->
	<cffunction name="init" returntype="category" access="remote">
		<cfargument name="item" type="any" required="true" />
		<cfset var category = new category() />
		<cfreturn category />
	</cffunction>

	<!--- Add category --->
	<cffunction name="createCategory" returntype="any" access="remote">
		<cfargument name="item" type="any" required="true" />
		<cfset var category = new category() />
		<cfif isNumeric(item.categoryID) AND item.categoryID NEQ 0>
			<cfset category.setCategoryID(item.categoryID) />
		</cfif>
		<cfset category.setCategoryName(item.categoryName) />
		<cfset category.setCategoryStatus(item.categoryStatus) />
		<cfset entitySave(category) />
		<!---- return created item ---->
		<cfreturn item />
	</cffunction>

	<!--- Save category --->
	<cffunction name="updateCategory" returntype="category" access="remote">
		<cfargument name="item" type="category" required="true" />
		<!--- update category --->
		<cfset entitySave(item) />
		<cfreturn item />
	</cffunction>

	<!--- Count category --->
	<cffunction name="count" returntype="numeric" access="remote">
		<cfreturn ORMExecuteQuery("select count(*) from category",true) />
	</cffunction>

	<!---- Delete category ---->
	<cffunction name="deleteCategory" returntype="void" access="remote">
		<cfargument name="categoryID" type="any" required="true" />
		<cfscript>
			var primaryKeysMap = {
				categoryID = categoryID
			};
			var item = entityLoad("category",primaryKeysMap,true);
			if (isnull(item) eq false) {
				entityDelete(item);
			}
		</cfscript>
	</cffunction>

	<!---- Get All category ---->
	<cffunction name="getAllCategory" returntype="category[]" access="remote">
		<cfreturn entityLoad("category") />
	</cffunction>

	<!--- Get All Paged category --->
	<cffunction name="getCategory_paged" returntype="category[]" access="remote">
		<cfargument name="startIndex" type="numeric" required="true" />
		<cfargument name="numItems" type="numeric" required="true" />
		<!--- return paged items --->
		<cfreturn entityLoad("category",{},"",{offset=startIndex,maxresults=numItems}) />
	</cffunction>

	<!--- Get category --->
	<cffunction name="getCategory" returntype="category" access="remote">
		 <cfargument name="categoryID" type="any" required="true" />
		<!--- return item --->
		<cfscript>
			var primaryKeysMap = {
				categoryID = categoryID
			};
			return entityLoad("category",primaryKeysMap,true);
		</cfscript>
	</cffunction>

</cfcomponent>