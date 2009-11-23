<cfset data = arguments />
<cfoutput>
<h2>MVC Examples - Returning Employee Data as an Array of Objects</h2>
#displayView("employee/menu")#
<h4>Employee Information:</h4>
Employee ID: #data.content[1].getEmployeeID()#<br />
User ID: #data.content[1].getUserID()#<br />
Name: #data.content[1].getFirstName()# #data.content[1].getLastName()# <br />
Location: #data.content[1].getLocation()#<br />
Job Title: #data.content[1].getTitle()#<br />
</cfoutput>