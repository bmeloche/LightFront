<cfcomponent extends="lfront.lightfront" output="false" hint="userType Service">

	<!---- Add userType ---->
	<cffunction name="createUserType" returntype="userType" access="remote">
		<cfargument name="item" type="userType" required="true" />
		<cfset entitySave(item) />
		<cfreturn item />
	</cffunction>

	<!---- Remove userType ---->
	<cffunction name="deleteuserType" returntype="void" access="remote">
		<cfargument name="userTypeID" type="any" required="true" />
		<cfscript>
			var primaryKeysMap = {
				userTypeID = arguments.userTypeID
			};
			var item = entityLoad("userType",primaryKeysMap,true);
			if (isNull(item) eq false) {
				entityDelete(item);
			}
		</cfscript>
	</cffunction>

	<!---- Get All userType ---->
	<cffunction name="getAllUserType" returntype="userType[]" access="remote">
		<!---- return items ---->
		<cfreturn entityLoad("userType") />
	</cffunction>

	<!---- Get All Paged userType ---->
	<cffunction name="getUserType_paged" returntype="userType[]" access="remote">
		<cfargument name="startIndex" type="numeric" required="true" />
		<cfargument name="numItems" type="numeric" required="true" />
		<!---- return paged items ---->
		<cfreturn entityLoad("userType",{},"",{offset=startIndex,maxresults=numItems}) />
	</cffunction>

	<!---- Get userType ---->
	<cffunction name="getuserType" returntype="userType" access="remote">
		 <cfargument name="userTypeID" type="any" required="true" />
		<!---- return item ---->
		<cfscript>
			var primaryKeysMap = {
				userTypeID = userTypeID
			};
			return entityLoad("userType",primaryKeysMap,true);
		</cfscript>
	</cffunction>

	<!---- Save userType ---->
	<cffunction name="updateUserType" returntype="userType" access="remote">
		<cfargument name="item" type="userType" required="true" />
		<!---- update userType ---->
		<cfset entitySave(item) />
		<cfreturn item />
	</cffunction>

	<!---- Count userType ---->
	<cffunction name="count" returntype="numeric" access="remote">
		<cfreturn ORMExecuteQuery("select count(*) from userType",true) />
	</cffunction>

</cfcomponent>
