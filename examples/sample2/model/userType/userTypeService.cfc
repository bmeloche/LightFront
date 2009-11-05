<cfcomponent output="false" hint="CFBuilder-Generated:userType">

	
	<!----
	USERTYPE SERVICES

	---->
	<!---- Add userType ---->

	<cffunction name="createuserType" returntype="userType" access="remote">
		<cfargument name="item" type="userType" required="true" />
		<!---- Auto-generated method
		  Insert a new record in userType ---->
		<cfset entitysave(item) />

		<!---- return created item ---->
		<cfreturn item/>
	</cffunction>

	<!---- Remove userType ---->
	<cffunction name="deleteuserType" returntype="void" access="remote">
		<cfargument name="userTypeID" type="any" required="true" />
		
		<!---- Auto-generated method
		         Delete a record in the database ---->
		<cfset var primaryKeysMap = { userTypeID = userTypeID }>
		<cfset var item=entityload("userType",primaryKeysMap,true)>
		<cfif isnull(item) eq false>
			<cfset entitydelete(item) />
		</cfif>
		<cfreturn />
	</cffunction>

	<!---- Get All userType ---->
	<cffunction name="getAlluserType" returntype="userType[]" access="remote">
		<!---- Auto-generated method
		        Retrieve set of records and return them as a query or array ---->
		<!---- return items ---->
		<cfreturn entityload("userType") />
	</cffunction>

	<!---- Get All Paged userType ---->
	<cffunction name="getuserType_paged" returntype="userType[]" access="remote">
		<cfargument name="startIndex" type="numeric" required="true" />
		<cfargument name="numItems" type="numeric" required="true" />
		<!---- Auto-generated method
		         Return a page of numRows number of records as an array or query from the database for this startRow ---->
		<!---- return paged items ---->
		<cfreturn entityload("userType",{},"",{offset=startIndex,maxresults=numItems})/>
	</cffunction>

	<!---- Get userType ---->
	<cffunction name="getuserType" returntype="userType" access="remote">
		 <cfargument name="userTypeID" type="any" required="true" /> 
		<!---- Auto-generated method
		         Retrieve a single record and return it ---->
		<!---- return item ---->
		<cfset var primaryKeysMap = { userTypeID = userTypeID }>
		<cfreturn entityload("userType",primaryKeysMap,true)>
	</cffunction>

	<!---- Save userType ---->
		<cffunction name="updateuserType" returntype="userType" access="remote">
		<cfargument name="item" type="userType" required="true" />
		<!---- Auto-generated method
		         Update an existing record in the database ---->
		<!---- update userType ---->
		<cfset entitysave(item) />
		<cfreturn item/>
	</cffunction>

	<!---- Count userType ---->
	<cffunction name="count" returntype="numeric" access="remote">
	
		<cfreturn ormexecutequery("select count(*) from userType",true)>
	</cffunction>

</cfcomponent> 
