<cfcomponent output="false" hint="CFBuilder-Generated:user">

	
	<!----
	USER SERVICES

	---->
	<!---- Add user ---->

	<cffunction name="createuser" returntype="user" access="remote">
		<cfargument name="item" type="user" required="true" />
		<!---- Auto-generated method
		  Insert a new record in user ---->
		<cfset entitysave(item) />

		<!---- return created item ---->
		<cfreturn item/>
	</cffunction>

	<!---- Remove user ---->
	<cffunction name="deleteuser" returntype="void" access="remote">
		<cfargument name="userID" type="any" required="true" />
		
		<!---- Auto-generated method
		         Delete a record in the database ---->
		<cfset var primaryKeysMap = { userID = userID }>
		<cfset var item=entityload("user",primaryKeysMap,true)>
		<cfif isnull(item) eq false>
			<cfset entitydelete(item) />
		</cfif>
		<cfreturn />
	</cffunction>

	<!---- Get All user ---->
	<cffunction name="getAlluser" returntype="user[]" access="remote">
		<!---- Auto-generated method
		        Retrieve set of records and return them as a query or array ---->
		<!---- return items ---->
		<cfreturn entityload("user") />
	</cffunction>

	<!---- Get All Paged user ---->
	<cffunction name="getuser_paged" returntype="user[]" access="remote">
		<cfargument name="startIndex" type="numeric" required="true" />
		<cfargument name="numItems" type="numeric" required="true" />
		<!---- Auto-generated method
		         Return a page of numRows number of records as an array or query from the database for this startRow ---->
		<!---- return paged items ---->
		<cfreturn entityload("user",{},"",{offset=startIndex,maxresults=numItems})/>
	</cffunction>

	<!---- Get user ---->
	<cffunction name="getuser" returntype="user" access="remote">
		 <cfargument name="userID" type="any" required="true" /> 
		<!---- Auto-generated method
		         Retrieve a single record and return it ---->
		<!---- return item ---->
		<cfset var primaryKeysMap = { userID = userID }>
		<cfreturn entityload("user",primaryKeysMap,true)>
	</cffunction>

	<!---- Save user ---->
		<cffunction name="updateuser" returntype="user" access="remote">
		<cfargument name="item" type="user" required="true" />
		<!---- Auto-generated method
		         Update an existing record in the database ---->
		<!---- update user ---->
		<cfset entitysave(item) />
		<cfreturn item/>
	</cffunction>

	<!---- Count user ---->
	<cffunction name="count" returntype="numeric" access="remote">
	
		<cfreturn ormexecutequery("select count(*) from user",true)>
	</cffunction>

	<cffunction name="getUserByUsernamePassword" returntype="any" access="remote">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPass" type="string" required="true" />
		<!---- Auto-generated method
		         Retrieve a single record and return it ---->
		<!---- return item ---->
		<cfset var primaryKeysMap = { userName = userName }>
		<cfreturn ormexecutequery("from user where userName = :userName and userPass = :userPass",{userName=userName,userPass=userPass})> 
	</cffunction>

</cfcomponent> 
