<cfcomponent persistent="true" table="userType"  schema="dbo" output="false">
	<!---- properties ---->
	
	<cfproperty name="userTypeID" column="userTypeID" type="numeric" ormtype="int" fieldtype="id"  /> 
	<cfproperty name="userType" column="userType" type="string" ormtype="string"  /> 
	<cfproperty name="userTypeStatus" column="userTypeStatus" type="numeric" ormtype="byte"  /> 	
</cfcomponent> 
