<cfcomponent persistent="true" table="user"  schema="dbo" output="false">
	<!---- properties ---->
	
	<cfproperty name="userID" column="userID" type="numeric" ormtype="int" fieldtype="id" /> 
	<cfproperty name="userGUID" column="userGUID" type="string" ormtype="string" /> 
	<cfproperty name="userName" column="userName" type="string" ormtype="string" /> 
	<cfproperty name="userPass" column="userPass" type="string" ormtype="string" /> 
	<cfproperty name="userStatus" column="userStatus" type="numeric" ormtype="int" /> 
	<cfproperty name="userFName" column="userFName" type="string" ormtype="string" />
	<cfproperty name="userMName" column="userMName" type="string" ormtype="string" />
	<cfproperty name="userLName" column="userLName" type="string" ormtype="string" />
	<cfproperty name="userTypeID" column="userType" type="numeric" ormtype="int" />
	<cfproperty name="userDateCreated" column="userDateCreated" type="date" ormtype="timestamp" />
	<cfproperty name="userDateModified" column="userDateModified" type="date" ormtype="timestamp" />
	<cfproperty name="userDateLastLogin" column="userDateLastLogin" type="date" ormtype="timestamp" />
</cfcomponent> 
