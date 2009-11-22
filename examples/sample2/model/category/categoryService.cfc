<cfcomponent displayname="categoryService" extends="org.lightfront.extensions.baseService" output="false">

	<!--- TODO: Later update.
	<cfset variables.thisInstance = arrayNew(1) />
	<cfset variables.thisStruct = structNew() />
	<cfset variables.thisStruct.fieldName = "categoryID" />
	<cfset variables.thisStruct.fieldType = "ID" />
	<cfset arrayAppend(thisInstance,thisStruct) />
	<cfset variables.thisStruct.fieldName = "categoryName" />
	<cfset variables.thisStruct.fieldType = "varchar" />
	<cfset arrayAppend(thisInstance,thisStruct) />
	<cfset variables.thisStruct.fieldName = "categoryStatus" />
	<cfset variables.thisStruct.fieldType = "boolean" />
	<cfset arrayAppend(thisInstance,thisStruct) /> --->

	<!--- Add category --->
	<cffunction name="createCategory" returntype="array" access="remote">
		<cfargument name="item" type="struct" required="true" />
		<cfset var hasErrors = validateCategory(item) />
		<cfif arrayLen(hasErrors) GT 0>
			<cfreturn hasErrors />
		<cfelse>
			<cfset create(item) />
		</cfif>
		<!--- return created item --->
		<cfreturn item />
	</cffunction>

	<!--- Remove category --->
	<cffunction name="deleteCategory" returntype="void" access="remote">
		<cfargument name="categoryID" type="any" required="true" />
		<cfscript>
			var primaryKeysMap = {
				categoryID = categoryID
			};
			var item = entityLoad("category",primaryKeysMap,true);
			if (isNull(item) eq false) {
				entityDelete(item);
			}
		</cfscript>
	</cffunction>

	<!--- Get All category --->
	<cffunction name="getAllCategory" returntype="category[]" access="remote">
		<!--- return items --->
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
			return entityload("category",primaryKeysMap,true);
		</cfscript>
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

	
	<cffunction name="validateCategory" access="public" returntype="array" output="false">
		<cfargument name="item" type="struct" required="false" default="#structNew()#" />
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
		<!--- categoryID --->
		<cfif (NOT len(trim(arguments.categoryID)))>
			<cfset thisError.field = "categoryID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Category ID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(arguments.categoryID())) AND NOT isNumeric(trim(arguments.categoryID())))>
			<cfset thisError.field = "categoryID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Category ID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<!--- categoryName --->
		<cfif (len(trim(arguments.categoryName())) AND NOT IsSimpleValue(trim(arguments.categoryName())))>
			<cfset thisError.field = "categoryName" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Category Name is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(arguments.categoryName())) GT 50)>
			<cfset thisError.field = "categoryName" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Category Name is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<!--- categoryStatus --->
		<cfif (len(trim(arguments.categoryStatus())) AND NOT isNumeric(trim(arguments.categoryStatus())))>
			<cfset thisError.field = "categoryStatus" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Category Status is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfreturn errors />
	</cffunction>
	
	<!---- create ---->
	<cffunction name="create" returntype="any">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="categoryStatus" type="numeric" required="true" />
		<cfset var IdentityCol = "" />
		<cfset var qry = "" />
		<!---- insert record ---->
		<cfquery name="qry" datasource="lightfront_sample2">
			INSERT INTO category (categoryName,categoryStatus)
			VALUES (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.categoryName#" null="false" />,
				<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#ARGUMENTS.categoryStatus#" null="false" />)
		</cfquery>
		<cfif arguments.categoryID NEQ "" AND arguments.categoryID NEQ 0>
			<cfset IdentityCol = arguments.categoryID>
		<cfelse>
	      	<cfif IsDefined("qry.GENERATEDKEY")>
	            <cfset identityCol = qry.GENERATEDKEY>
			<cfelseif IsDefined("qry.IDENTITYCOL")>
	            <cfset identityCol = qry.IDENTITYCOL>
	      	<cfelseif IsDefined("qry.GENERATED_KEYS")>
	            <cfset identityCol = qry.GENERATED_KEYS>
	      	<cfelseif IsDefined("qry.KEY_VALUE")>
	            <cfset identityCol = qry.KEY_VALUE>
	      	</cfif>
	  	</cfif>	
		<!---- return IdentityCol ---->
		<cfreturn IdentityCol />
	</cffunction>

	<!---- read ---->
	<cffunction name="read" returntype="array">
		<cfargument name="id" type="any" required="true" />
		<cfset var arr = arrayNew(1) />
		<cfset var struct = structNew() />
		<cfset var i = 1 />
		<cfset var qry = "" />
		
		<cfquery name="qry" datasource="lightfront_sample2">
			SELECT categoryid,categoryname,categorystatus
			FROM category
			WHERE categoryid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.id#" null="false" />
		</cfquery>
		<!---- Load an array of structures ---->
		<cfset struct.categoryID = qry.categoryID[i] />
		<cfset struct.categoryName = qry.categoryName[i] />
		<cfset struct.categoryStatus = qry.categoryStatus[i] />
		<cfset arrayAppend(arr,struct) />
		<!---- return an array of Structures ---->
		<cfreturn arr />
	</cffunction>

	<!---- update ---->
	<cffunction name="update" returntype="void">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="categoryStatus" type="numeric" required="true" /> 
		<cfset var qry = "" />
		<!---- update database ---->
		<cfquery name="qry" datasource="lightfront_sample2">
			UPDATE category
			SET categoryName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.categoryName#" null="false" />,
				categoryStatus = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#ARGUMENTS.categoryStatus#" null="false" />
			WHERE categoryID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.categoryID#" null="false" />
		</cfquery>
	</cffunction>

	<!---- delete ---->
	<cffunction name="delete" returntype="void">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfset var qry = "" />
		<!---- delete from database ---->
		<cfquery name="qry" datasource="lightfront_sample2">
			DELETE FROM category
			WHERE categoryID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ARGUMENTS.categoryID#" null="false" />
		</cfquery>
	</cffunction>

	<!--- Converts a query to an array of structures. --->
	<cffunction name="queryToArrayOfStructures" returntype="Array" hint="Converts a query object into an array of structures.">
		<cfargument name="theQuery" type="Query" required="true" />
		<cfscript>
			var theArray = arrayNew(1);
			var cols = listtoArray(arguments.theQuery.columnlist);
			var row = 1;
			var thisRow = "";
			var col = 1;
			for(row = 1; row LTE arguments.theQuery.recordcount; row = row + 1) {
				thisRow = structNew();
				for(col = 1; col LTE arrayLen(cols); col = col + 1) {
					thisRow[cols[col]] = arguments.theQuery[cols[col]][row];
				}
				arrayAppend(theArray,duplicate(thisRow));
			}
			return(theArray);
		</cfscript>
	</cffunction>

</cfcomponent>