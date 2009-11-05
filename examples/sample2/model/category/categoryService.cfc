<cfcomponent displayname="categoryService" output="false">

	<!--- Add category --->
	<cffunction name="createcategory" returntype="category" access="remote">
		<cfargument name="item" type="category" required="true" />
		<!--- Auto-generated method; Insert a new record in category --->
		<cfset entitysave(item) />
		<!--- return created item --->
		<cfreturn item/>
	</cffunction>

	<!--- Remove category --->
	<cffunction name="deletecategory" returntype="void" access="remote">
		<cfargument name="categoryID" type="any" required="true" />
		<!--- Auto-generated method; Delete a record in the database --->
		<cfset var primaryKeysMap = { categoryID = categoryID }>
		<cfset var item=entityload("category",primaryKeysMap,true)>
		<cfif isnull(item) eq false>
			<cfset entitydelete(item) />
		</cfif>
		<cfreturn />
	</cffunction>

	<!--- Get All category --->
	<cffunction name="getAllcategory" returntype="category[]" access="remote">
		<!--- Auto-generated method; Retrieve set of records and return them as a query or array --->
		<!--- return items --->
		<cfreturn entityload("category") />
	</cffunction>

	<!--- Get All Paged category --->
	<cffunction name="getcategory_paged" returntype="category[]" access="remote">
		<cfargument name="startIndex" type="numeric" required="true" />
		<cfargument name="numItems" type="numeric" required="true" />
		<!--- Auto-generated method; Return a page of numRows number of records as an array or query from the database for this startRow --->
		<!--- return paged items --->
		<cfreturn entityload("category",{},"",{offset=startIndex,maxresults=numItems})/>
	</cffunction>

	<!--- Get category --->
	<cffunction name="getcategory" returntype="category" access="remote">
		 <cfargument name="categoryID" type="any" required="true" /> 
		<!--- Auto-generated method; Retrieve a single record and return it --->
		<!--- return item --->
		<cfset var primaryKeysMap = { categoryID = categoryID }>
		<cfreturn entityload("category",primaryKeysMap,true)>
	</cffunction>

	<!--- Save category --->
	<cffunction name="updatecategory" returntype="category" access="remote">
		<cfargument name="item" type="category" required="true" />
		<!--- Auto-generated method; Update an existing record in the database --->
		<!--- update category --->
		<cfset entitysave(item) />
		<cfreturn item/>
	</cffunction>

	<!--- Count category --->
	<cffunction name="count" returntype="numeric" access="remote">
		<cfreturn ormexecutequery("select count(*) from category",true)>
	</cffunction>

</cfcomponent>