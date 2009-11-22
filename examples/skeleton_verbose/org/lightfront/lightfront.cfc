<cfcomponent>
<cfset lightfrontPath = ExpandPath('org/lightfront') />
<cfthrow message="READ THE <a href='README.txt'>README.txt</a> file!!!<br /><br />Please copy /org/lightfront/lightfront.cfc to #lightfrontPath#, your site root, create a ColdFusion mapping in the administrator, or change Application.cfc to extend to the correct location." detail="Please delete the current #lightfrontPath##iif(lightfrontPath CONTAINS '\',DE('\'),DE('/'))#lightfront.cfc. If LightFront will exist somewhere else, please delete the #lightfrontPath# folder entirely.">
</cfcomponent>