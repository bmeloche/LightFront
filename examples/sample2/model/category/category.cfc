<cfcomponent persistent="true" table="category" schema="dbo" output="false">

	<!---- properties ---->
	<cfproperty name="categoryID" column="categoryID" type="numeric" ormtype="int" fieldtype="id" />
	<cfproperty name="categoryName" column="categoryName" type="string" ormtype="string" />
	<cfproperty name="categoryStatus" column="categoryStatus" type="numeric" ormtype="byte" />

</cfcomponent>
