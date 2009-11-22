<cfcomponent displayname="userService" extends="org.lightfront.lightfront" output="false" hint="user service">

	<!---- Add user ---->
	<cffunction name="createUser" returntype="user" access="remote">
		<cfargument name="item" type="user" required="true" />
		<cfset entitySave(item) />
		<!---- return created item ---->
		<cfreturn item />
	</cffunction>

	<!---- Delete user ---->
	<cffunction name="deleteUser" returntype="void" access="remote">
		<cfargument name="userID" type="any" required="true" />
		<cfscript>
			var primaryKeysMap = {
				userID = userID
			};
			var item = entityLoad("user",primaryKeysMap,true);
			if (isnull(item) eq false) {
				entityDelete(item);
			}
		</cfscript>
	</cffunction>

	<!---- Get All user ---->
	<cffunction name="getAllUser" returntype="user[]" access="remote">
		<cfreturn entityLoad("user") />
	</cffunction>

	<!---- Get All Paged user ---->
	<cffunction name="getuser_paged" returntype="user[]" access="remote">
		<cfargument name="startIndex" type="numeric" required="true" />
		<cfargument name="numItems" type="numeric" required="true" />
		<!---- return paged items ---->
		<cfreturn entityLoad("user",{},"",{offset=startIndex,maxresults=numItems}) />
	</cffunction>

	<!---- Get user ---->
	<cffunction name="getUser" returntype="user" access="remote">
		 <cfargument name="userID" type="any" required="true" /> 
		<!---- return item ---->
		<cfscript>
			var primaryKeysMap = {
				userID = userID
			};
			entityLoad("user",primaryKeysMap,true);
		</cfscript>
	</cffunction>

	<!---- Save user ---->
		<cffunction name="updateuser" returntype="user" access="remote">
		<cfargument name="item" type="user" required="true" />
		<!---- update user ---->
		<cfset entitySave(item) />
		<cfreturn item />
	</cffunction>

	<!---- Count user ---->
	<cffunction name="count" returntype="numeric" access="remote">	
		<cfreturn ORMExecuteQuery("select count(*) from user",true) />
	</cffunction>

	<cffunction name="getUserByUsernamePassword" returntype="any" access="remote">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPass" type="string" required="true" />
		<cfscript>
			var primaryKeysMap = {
				userName = userName
			};
			return ORMExecuteQuery("from user where userName = :userName and userPass = :userPass",{userName=userName,userPass=userPass}); 
		</cfscript>
	</cffunction>

</cfcomponent>