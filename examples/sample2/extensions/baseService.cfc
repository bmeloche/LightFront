<cfcomponent displayname="baseObject" hint="I am a helper for service CFCs." output="false">


	<cffunction name="createGUID" access="public" returntype="guid" output="false" hint="Returns a UUID in the Microsoft form.">
		<cfreturn insert("-",createUUID(),23)>
	</cffunction>

	<cffunction name="toXML" output="false" returntype="String" hint="Convert Structures/Arrays (including embedded) to XML.">
		<cfargument name="input" type="Any" required="true">
		<cfargument name="element" type="string" required="true">
		<cfscript>
			var i = 0;
			var s = "";
			var s1 = "";
			s1 = arguments.element;
			if (right(s1,1) eq "s") {
				s1 = left(s1,len(s1)-1);
			}
			s = s & "<#lcase(arguments.element)#>";
			if (isArray(arguments.input)) {
				for (i = 1; i lte arrayLen(arguments.input); i = i + 1) {
					if (isSimpleValue(arguments.input[i])) {
						s = s & "<#lcase(s1)#>" & arguments.input[i] & "</#lcase(s1)#>";
					}
					else {
						s = s & toXML(arguments.input[i],s1);
					}
				}
			}
			else if (isStruct(arguments.input)) {
				for (i in arguments.input) {
					if (isSimpleValue(arguments.input[i])) {
						s = s & "<#lcase(i)#>" & arguments.input[i] & "</#lcase(i)#>";
					}
					else {
						s = s & toXML(arguments.input[i],i);
					}
				}
			}
			else {
				s = s & XMLFormat(arguments.input);
			}
			s = s & "</#lcase(arguments.element)#>";
		</cfscript>
		<cfreturn s>
	</cffunction>

	<cffunction name="xmlToJson" output="false" returntype="any" hint="convert xml to JSON">
		<cfargument name="xml" default="" required="false" hint="raw xml">
		<cfargument name="includeFormatting" type="boolean" default="false" required="false" hint="whether or not to maintain and encode tabs, linefeeds and carriage returns">
		<cfset var result = "">
		<cfset var xsl = "">
		<cfsavecontent variable="xsl">
			<?xml version="1.0" encoding="UTF-8"?>
			<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
				<xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="UTF-8" media-type="application/json"/>
				<xsl:strip-space elements="*"/>
				<!-- used to identify unique children in Muenchian grouping, credit Martynas Jusevicius http://www.xml.lt -->
				<xsl:key name="elements-by-name" match="@* | *" use="concat(generate-id(..), '@', name(.))"/>
				<!-- string -->
				<xsl:template match="text()">
					<xsl:call-template name="processValues">
						<xsl:with-param name="s" select="."/>
					</xsl:call-template>
				</xsl:template>
				<!-- text values (from text nodes and attributes) -->
				<xsl:template name="processValues">
					<xsl:param name="s"/>
					<xsl:choose>
						<!-- number -->
						<xsl:when test="not(string(number($s))='NaN')">
							<xsl:value-of select="$s"/>
						</xsl:when>
						<!-- boolean -->
						<xsl:when test="translate($s,'TRUE','true')='true'">true</xsl:when>
						<xsl:when test="translate($s,'FALSE','false')='false'">false</xsl:when>
						<!-- string -->
						<xsl:otherwise>
							<xsl:call-template name="escapeArtist">
								<xsl:with-param name="s" select="$s"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
				<!-- begin filter chain -->
				<xsl:template name="escapeArtist">
					<xsl:param name="s"/>
					"
					<xsl:call-template name="escapeBackslash">
						<xsl:with-param name="s" select="$s"/>
					</xsl:call-template>
					"
				</xsl:template>
				<!-- escape the backslash (\) before everything else. -->
				<xsl:template name="escapeBackslash">
					<xsl:param name="s"/>
					<xsl:choose>
						<xsl:when test="contains($s,'\')">
							<xsl:call-template name="escapeQuotes">
								<xsl:with-param name="s" select="concat(substring-before($s,'\'),'\\')"/>
							</xsl:call-template>
							<xsl:call-template name="escapeBackslash">
								<xsl:with-param name="s" select="substring-after($s,'\')"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="escapeQuotes">
								<xsl:with-param name="s" select="$s"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
				<!-- escape the double quote ("). -->
				<xsl:template name="escapeQuotes">
					<xsl:param name="s"/>
					<xsl:choose>
						<xsl:when test="contains($s,'&quot;')">
							<xsl:call-template name="encoder">
								<xsl:with-param name="s" select="concat(substring-before($s,'&quot;'),'\&quot;')"/>
							</xsl:call-template>
							<xsl:call-template name="escapeQuotes">
								<xsl:with-param name="s" select="substring-after($s,'&quot;')"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="encoder">
								<xsl:with-param name="s" select="$s"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
				<!-- encode tab, line feed and/or carriage return-->
				<xsl:template name="encoder">
					<xsl:param name="s"/>
					<xsl:choose>
						<!-- tab -->
						<xsl:when test="contains($s,'&#x9;')">
							<xsl:call-template name="encoder">
								<xsl:with-param name="s" select="concat(substring-before($s,'&#x9;'),'<cfoutput>#iif(arguments.includeFormatting,DE("\t"),DE(" "))#</cfoutput>',substring-after($s,'&#x9;'))"/>
							</xsl:call-template>
						</xsl:when>
						<!-- line feed -->
						<xsl:when test="contains($s,'&#xA;')">
							<xsl:call-template name="encoder">
								<xsl:with-param name="s" select="concat(substring-before($s,'&#xA;'),'<cfoutput>#iif(arguments.includeFormatting,DE("\n"),DE(" "))#</cfoutput>',substring-after($s,'&#xA;'))"/>
							</xsl:call-template>
						</xsl:when>
						<!-- carriage return -->
						<xsl:when test="contains($s,'&#xD;')">
							<xsl:call-template name="encoder">
								<xsl:with-param name="s" select="concat(substring-before($s,'&#xD;'),'<cfoutput>#iif(arguments.includeFormatting,DE("\r"),DE(" "))#</cfoutput>',substring-after($s,'&#xD;'))"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="$s"/></xsl:otherwise>
					</xsl:choose>
				</xsl:template>
				<!-- main handler template
					creates a struct containing: the node text(); struct of attributes; and set a struct key for any node children.
					this template then drills into the children, repeating itself until complete
				-->
				<xsl:template name="processNode">
					{
						"text":
						<xsl:call-template name="escapeArtist">
							<xsl:with-param name="s" select="key('elements-by-name', concat(generate-id(..), '@', name(.)))/text()"/>
						</xsl:call-template>
						,"attributes":{
						<xsl:for-each select="@*">
							<xsl:call-template name="escapeArtist">
								<xsl:with-param name="s" select="name()"/>
							</xsl:call-template>
							:
							<xsl:call-template name="processValues">
								<xsl:with-param name="s" select="."/>
							</xsl:call-template>
							<xsl:if test="position() &lt; count(parent::node()/attribute::*)">
								,
							</xsl:if>
						</xsl:for-each>
					}
					<!-- drill down the tree -->
					<xsl:for-each select="*[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.))))]">
						,
						<xsl:call-template name="escapeArtist">
							<xsl:with-param name="s" select="name()"/>
						</xsl:call-template>
						:
						<xsl:apply-templates select="."/>
					</xsl:for-each>
					}
				</xsl:template>
				<!-- main parser
					basically a node 'loop' - performed once for all matches of *, so once for each node including the root.
					note: this loop has no knowledge of other iterations it may have performed.
				-->
				<xsl:template match="*">
					<!-- determine whether any peers share the node name, so we can spool off into 'array mode' -->
					<xsl:variable name="isArray" select="count(key('elements-by-name', concat(generate-id(..), '@', name(.)))) &gt; 1"/>
					<xsl:if test="count(ancestor::node()) = 1"><!-- begin the root node-->
						{
						<xsl:call-template name="escapeArtist">
							<xsl:with-param name="s" select="name()"/>
						</xsl:call-template>
						:
					</xsl:if>
					<xsl:if test="not($isArray)">
						<xsl:call-template name="processNode">
							<xsl:with-param name="s" select="."/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$isArray">
						[
						<xsl:apply-templates select="key('elements-by-name', concat(generate-id(..), '@', name(.)))" mode="array"/>
						]
					</xsl:if>
					<xsl:if test="count(ancestor::node()) = 1">}</xsl:if><!-- close the root node -->
				</xsl:template>
				<!-- array template called from main parser -->
				<xsl:template match="*" mode="array">
					<xsl:call-template name="processNode">
						<xsl:with-param name="s" select="."/>
					</xsl:call-template>
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:template>
			</xsl:stylesheet>
		</cfsavecontent>
		<cfset xsl = XMLParse(reReplace(xsl,'([\s\S\w\W]*)(<\?xml)','\2','all'))>
		<cfscript>
			result = arguments.xml;
			result = reReplace(result,'([\s\S\w\W]*)(<\?xml)','\2','all');
			result = XMLTransform(trim(result),xsl);
			return result;
		</cfscript>
	</cffunction>

	<cffunction name="JSONDecode" access="remote" returntype="any" output="no" hint="Converts data frm JSON to CF format. DeSerialize JSON data into ColdFusion native objects (simple value, array, structure, query).">
		<cfargument name="data" type="string" required="true">
		<!--- DECLARE VARIABLES --->
		<cfset var local = structNew()>
		<cfset local.ar = arrayNew(1)>
		<cfset local.st = structNew()>
		<cfset local.dataType = "">
		<cfset local.inQuotes = false>
		<cfset local.startPos = 1>
		<cfset local.nestingLevel = 0>
		<cfset local.dataSize = 0>
		<cfset local.i = 1>
		<cfset local.skipIncrement = false>
		<cfset local.j = 0>
		<cfset local.char = "">
		<cfset local.dataStr = "">
		<cfset local.structVal = "">
		<cfset local.structKey = "">
		<cfset local.colonPos = "">
		<cfset local.qRows = 0>
		<cfset local.qCol = "">
		<cfset local.qData = "">
		<cfset local.curCharIndex = "">
		<cfset local.curChar = "">
		<cfset local.result = "">
		<cfset local.unescapeVals = "\\,\"",\/,\b,\t,\n,\f,\r">
		<cfset local.unescapeToVals = "\,"",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#">
		<cfset local.unescapeVals2 = '\,",/,b,t,n,f,r'>
		<cfset local.unescapeToVals2 = '\,",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#'>
		<cfset local.dJSONString = "">
		<cfset local._data = trim(arguments.data)>
		<!--- NUMBER --->
		<cfif isNumeric(local._data)>
			<cfreturn local._data>
		<!--- NULL --->
		<cfelseif local._data EQ "null">
			<cfreturn "">
		<!--- BOOLEAN --->
		<cfelseif listFindNoCase("true,false",local._data)>
			<cfreturn local._data>
		<!--- EMPTY STRING --->
		<cfelseif local._data EQ "'" OR local._data EQ '""'>
			<cfreturn "">
		<!--- STRING --->
		<cfelseif find('^"[^\\"]*(?:\\.[^\\"]*)*"$',local._data) EQ 1 OR reFind("^'[^\\']*(?:\\.[^\\']*)*'$",local._data) EQ 1>
			<cfset local._data = mid(local._data,2,len(local._data)-2)>
			<!--- If there are any \b, \t, \n, \f, and \r, do extra processing (required because ReplaceList() won't work with those) --->
			<cfif find("\b",local._data) OR find("\t",local._data) OR find("\n",local._data) OR find("\f",local._data) OR find("\r",local._data)>
				<cfset local.curCharIndex = 0>
				<cfset local.curChar = "">
				<cfset local.dJSONString = createObject("java","java.lang.StringBuffer").init("")>
				<cfloop condition="true">
					<cfset local.curCharIndex = local.curCharIndex + 1>
					<cfif local.curCharIndex GT len(local._data)>
						<cfbreak>
					<cfelse>
						<cfset local.curChar = mid(local._data,local.curCharIndex,1)>
						<cfif local.curChar EQ "\">
							<cfset local.curCharIndex = local.curCharIndex + 1>
							<cfset local.curChar = mid(local._data,local.curCharIndex,1)>
							<cfset pos = listFind(local.unescapeVals2,curChar)>
							<cfif pos>
								<cfset local.dJSONString.append(listGetAt(local.unescapeToVals2,pos))>
							<cfelse>
								<cfset local.dJSONString.append("\" & local.curChar)>
							</cfif>
						<cfelse>
							<cfset local.dJSONString.append(local.curChar)>
						</cfif>
					</cfif>
				</cfloop>
				<cfreturn local.dJSONString.toString()>
			<cfelse>
				<cfreturn replaceList(local._data,local.unescapeVals,local.unescapeToVals)>
			</cfif>
		<!--- ARRAY, STRUCT, OR QUERY --->
		<cfelseif (left(local._data,1) EQ "[" AND right(local._data,1) EQ "]") OR (left(local._data,1) EQ "{" AND right(local._data,1) EQ "}")>
			<!--- Store the data type we're dealing with --->
			<cfif left(local._data,1) EQ "[" AND right(local._data,1) EQ "]">
				<cfset local.dataType = "array">
			<cfelseif reFindNoCase('^\{"recordcount":[0-9]+,"columnlist":"[^"]+","data":\{("[^"]+":\[[^]]*\],?)+\}\}$',local._data,0) EQ 1>
				<cfset local.dataType = "query">
			<cfelse>
				<cfset local.dataType = "struct">
			</cfif>
			<!--- Remove the brackets --->
			<cfset local._data = trim(mid(local._data,2,len(local._data)-2))>
			<!--- Deal with empty array/struct --->
			<cfif len(local._data) EQ 0>
				<cfif local.dataType EQ "array">
					<cfreturn local.ar>
				<cfelse>
					<cfreturn local.st>
				</cfif>
			</cfif>
			<!--- Loop through the string characters --->
			<cfset local.dataSize = len(local._data) + 1>
			<cfloop condition="#local.i# LTE #local.dataSize#">
				<cfset local.skipIncrement = false>
				<!--- Save current character --->
				<cfset local.char = mid(local._data,local.i,1)>
				<!--- If char is a quote, switch the quote status --->
				<cfif local.char EQ '"'>
					<cfset local.inQuotes = NOT local.inQuotes>
					<!--- If char is escape character, skip the next character --->
				<cfelseif local.char EQ "\" AND local.inQuotes>
					<cfset local.i = local.i + 2>
					<cfset local.skipIncrement = true>
					<!--- If char is a comma and is not in quotes, or if end of string, deal with data --->
				<cfelseif (local.char EQ "," AND NOT local.inQuotes AND local.nestingLevel EQ 0) OR local.i EQ len(local._data)+1>
					<cfset local.dataStr = mid(local._data,local.startPos,local.i-local.startPos)>
					<!--- If data type is array, append data to the array --->
					<cfif local.dataType EQ "array">
						<cfset arrayappend(local.ar,JSONDecode(local.dataStr))>
						<!--- If data type is struct or query... --->
					<cfelseif local.dataType EQ "struct" OR local.dataType EQ "query">
						<cfset local.dataStr = mid(local._data,local.startPos,local.i-local.startPos)>
						<cfset local.colonPos = find('":',local.dataStr)>
						<cfif local.colonPos>
							<cfset local.colonPos = local.colonPos + 1>
						<cfelse>
							<cfset local.colonPos = find(":",local.dataStr)>
						</cfif>
						<cfset local.structKey = trim(mid(local.dataStr,1,local.colonPos-1))>
						<!--- If needed, remove quotes from keys --->
						<cfif left(local.structKey,1) EQ "'" OR left(local.structKey,1) EQ '"'>
							<cfset local.structKey = mid(local.structKey,2,len(local.structKey)-2)>
						</cfif>
						<cfset local.structVal = mid(local.dataStr,local.colonPos+1,len(local.dataStr)-local.colonPos)>
						<!--- If struct, add to the structure --->
						<cfif local.dataType EQ "struct">
							<cfset structInsert(local.st,local.structKey,JSONDecode(local.structVal))>
							<!--- If query, build the query --->
						<cfelse>
							<cfif local.structKey EQ "recordcount">
								<cfset local.qRows = JSONDecode(local.structVal)>
							<cfelseif local.structKey EQ "columnlist">
								<cfset local.st = queryNew(JSONDecode(local.structVal))>
								<cfif local.qRows>
									<cfset queryAddRow(local.st,local.qRows)>
								</cfif>
							<cfelseif local.structKey EQ "data">
							<cfset local.qData = JSONDecode(local.structVal)>
							<cfset local.ar = structKeyArray(local.qData)>
							<cfloop from="1" to="#ArrayLen(ar)#" index="local.j">
								<cfloop from="1" to="#local.st.recordcount#" index="local.qRows">
									<cfset local.qCol = local.ar[local.j]>
									<cfset querySetCell(local.st,local.qCol,local.qData[local.qCol][local.qRows],local.qRows)>
								</cfloop>
							</cfloop>
						</cfif>
					</cfif>
				</cfif>
				<cfset local.startPos = local.i + 1>
				<!--- If starting a new array or struct, add to nesting level --->
				<cfelseif "{[" CONTAINS local.char AND NOT local.inQuotes>
					<cfset local.nestingLevel = local.nestingLevel + 1>
					<!--- If ending an array or struct, subtract from nesting level --->
				<cfelseif "]}" CONTAINS local.char AND NOT local.inQuotes>
					<cfset local.nestingLevel = local.nestingLevel - 1>
				</cfif>
				<cfif NOT local.skipIncrement>
					<cfset local.i = local.i + 1>
				</cfif>
			</cfloop>
			<!--- Return appropriate value based on data type --->
			<cfif local.dataType EQ "array">
				<cfreturn local.ar>
			<cfelse>
				<cfreturn local.st>
			</cfif>
		<!--- INVALID JSON --->
		<cfelse>
			<cfthrow message="Invalid JSON" detail="The document you are trying to JSONDecode is not in valid JSON format">
		</cfif>
	</cffunction>

	<cffunction name="JSONEncode" access="remote" returntype="string" output="No" hint="Converts data from CF to JSON format. Serialize native ColdFusion objects into a JSON formated string.">
		<cfargument name="data" type="any" required="Yes">
		<cfargument name="queryFormat" type="string" required="No" default="query" hint="query or array">
		<cfargument name="queryKeyCase" type="string" required="No" default="lower" hint="lower or upper">
		<cfargument name="stringNumbers" type="boolean" required="No" default="false">
		<cfargument name="formatDates" type="boolean" required="No" default="false">
		<cfargument name="columnListFormat" type="string" required="No" default="string" hint="string or array">
		<!--- VARIABLE DECLARATION --->
		<cfset var local = structNew()>
		<cfset local.JSONString = "">
		<cfset local.tempVal = "">
		<cfset local.arKeys = "">
		<cfset local.colPos = 1>
		<cfset local.i = 1>
		<cfset local.column = "">
		<cfset local.dataKey = "">
		<cfset local.recordCountKey = "">
		<cfset local.columnList = "">
		<cfset local.columnListkey = "">
		<cfset local.dJSONString = "">
		<cfset local.escapeToVals = "\\,\"",\/,\b,\t,\n,\f,\r">
		<cfset local.escapeVals = "\,"",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#">
		<cfset local._data = arguments.data>
		<!--- BOOLEAN --->
		<cfif isBoolean(local._data) AND NOT isNumeric(local._data) AND NOT listFindNoCase("Yes,No",local._data)>
			<cfreturn lCase(ToString(local._data))>
		<!--- NUMBER --->
		<cfelseif NOT stringNumbers AND isNumeric(local._data) AND NOT REFind("^0+[^\.]",local._data)>
			<cfreturn ToString(local._data)>
		<!--- DATE --->
		<cfelseif isDate(local._data) AND arguments.formatDates>
			<cfreturn '"#DateFormat(local._data,"medium")# #TimeFormat(local._data,"medium")#"'>
		<!--- STRING --->
		<cfelseif isSimpleValue(local._data)>
			<cfreturn '"' & replaceList(local._data,local.escapeVals,local.escapeToVals) & '"'>
		<!--- ARRAY --->
		<cfelseif isArray(local._data)>
			<cfset dJSONString = createObject('java','java.lang.StringBuffer').init("")>
			<cfloop from="1" to="#ArrayLen(local._data)#" index="local.i">
				<cfset local.tempVal = JSONEncode( local._data[local.i],arguments.queryFormat,arguments.queryKeyCase,arguments.stringNumbers,arguments.formatDates,arguments.columnListFormat )>
				<cfif local.dJSONString.toString() EQ "">
					<cfset local.dJSONString.append(local.tempVal)>
				<cfelse>
					<cfset local.dJSONString.append("," & local.tempVal)>
				</cfif>
			</cfloop>
			<cfreturn "[" & local.dJSONString.toString() & "]">
		<!--- STRUCT --->
		<cfelseif isStruct(local._data)>
			<cfset dJSONString = createObject('java','java.lang.StringBuffer').init("")>
			<cfset local.arKeys = StructKeyArray(local._data)>
			<cfloop from="1" to="#ArrayLen(local.arKeys)#" index="local.i">
				<cfset local.tempVal = JSONEncode(local._data[local.arKeys[local.i] ],arguments.queryFormat,arguments.queryKeyCase,arguments.stringNumbers,arguments.formatDates,arguments.columnListFormat )>
				<cfif local.dJSONString.toString() EQ "">
					<cfset local.dJSONString.append('"' & local.arKeys[local.i] & '":' & local.tempVal)>
				<cfelse>
					 <cfset local.dJSONString.append("," & '"' & local.arKeys[local.i] & '":' & local.tempVal)>
				</cfif>
			</cfloop>
			<cfreturn "{" & local.dJSONString.toString() & "}">
		<!--- QUERY --->
		<cfelseif isQuery(local._data)>
			<cfset dJSONString = createObject('java','java.lang.StringBuffer').init("")>
			<!--- Add query meta data --->
			<cfif arguments.queryKeyCase EQ "lower">
				<cfset local.recordCountKey = "recordcount">
				<cfset local.columnListKey = "columnlist">
				<cfset local.columnList = lCase(local._data.columnlist)>
				<cfset local.dataKey = "data">
			<cfelse>
				<cfset local.recordCountKey = "RECORDCOUNT">
				<cfset local.columnListKey = "COLUMNLIST">
				<cfset local.columnList = local._data.columnlist>
				<cfset local.dataKey = "data">
			</cfif>
			<cfset local.dJSONString.append('"#local.recordCountKey#":' & local._data.recordcount)>
			<cfif arguments.columnListFormat EQ "array">
				<cfset local.columnList = "[" & listQualify(local.columnList,'"') & "]">
				<cfset local.dJSONString.append(',"#local.columnListKey#":' & local.columnList)>
			<cfelse>
				<cfset local.dJSONString.append(',"#local.columnListKey#":"' & local.columnList & '"')>
			</cfif>
			<cfset local.dJSONString.append(',"#local.dataKey#":')>
			<!--- Make query a structure of arrays --->
			<cfif arguments.queryFormat EQ "query">
			<cfset local.dJSONString.append("{")>
				<cfset local.colPos = 1>
				<cfloop list="#local._data.columnlist#" delimiters="," index="local.column">
					<cfif local.colPos GT 1>
						<cfset local.dJSONString.append(",")>
					</cfif>
					<cfif arguments.queryKeyCase EQ "lower">
						<cfset local.column = lCase(local.column)>
					</cfif>
					<cfset local.dJSONString.append('"' & local.column & '":[')>
					<cfloop from="1" to="#local._data.recordcount#" index="local.i">
						<!--- Get cell value; recurse to get proper format depending on string/number/boolean data type --->
						<cfset local.tempVal = JSONEncode(local._data[local.column][local.i],arguments.queryFormat,arguments.queryKeyCase,arguments.stringNumbers,arguments.formatDates,arguments.columnListFormat)>
						<cfif local.i GT 1>
							<cfset local.dJSONString.append(",")>
						</cfif>
						<cfset local.dJSONString.append(local.tempVal)>
					</cfloop>
					<cfset local.dJSONString.append("]")>
					<cfset local.colPos = local.colPos + 1>
				</cfloop>
				<cfset local.dJSONString.append("}")>
			<!--- Make query an array of structures --->
			<cfelse>
				<cfset local.dJSONString.append("[")>
				<cfloop query="local._data">
					<cfif CurrentRow GT 1>
						<cfset local.dJSONString.append(",")>
					</cfif>
					<cfset local.dJSONString.append("{")>
					<cfset local.colPos = 1>
					<cfloop list="#local.columnList#" delimiters="," index="local.column">
						<cfset local.tempVal = JSONEncode(local._data[local.column][CurrentRow],arguments.queryFormat,arguments.queryKeyCase,arguments.stringNumbers,arguments.formatDates,arguments.columnListFormat )>
						<cfif local.colPos GT 1>
							<cfset local.dJSONString.append(",")>
						</cfif>
						<cfif arguments.queryKeyCase EQ "lower">
							<cfset local.column = lCase(local.column)>
						</cfif>
						<cfset local.dJSONString.append('"' & local.column & '":' & local.tempVal)>
						<cfset local.colPos = local.colPos + 1>
					</cfloop>
					<cfset local.dJSONString.append("}")>
				</cfloop>
				<cfset local.dJSONString.append("]")>
			</cfif>
			<!--- Wrap all query data into an object --->
			<cfreturn "{" & local.dJSONString.toString() & "}">
	    <!--- UNKNOWN OBJECT TYPE --->
	    <cfelse>
			<cfreturn '"' & "unknown-obj" & '"'>
	    </cfif>
	</cffunction>

	<cffunction name="getAllQueryMSSQL" access="public" returntype="query" hint="I get the columns in a Microsoft SQL Server query, according to WHERE and ORDER BY.">
		<cfargument name="tableName" type="string" required="true" hint="The name of the table you want.">
		<cfargument name="DSN" type="string" required="true" default="#application.dsn#" hint="I am the datasource.">
		<!---<cfargument name="columns" type="string" required="true" default="*" hint="I am the columns you want.">--->
		<cfargument name="where" type="array" required="false" hint="I am the where clause.">
		<cfargument name="orderby" type="string" required="false" hint="I am the order by clause.">
		<cfset var i = 0>
		<cfset var tmpQry = "">
		<cfquery name="tmpQry" datasource="#arguments.DSN#">
			SELECT * FROM #arguments.tableName#
			<cfif structKeyExists(arguments,where) AND isArray(arguments.where)>
				WHERE
				<cfloop from="1" to="#arrayLen(arguments.where)#" index="i">
					#arguments.where[i][columnName]# = <cfqueryparam cfsqltype="#arguments.where[i][columnType]#" value="#arguments.where[i][columnValue]#">
				</cfloop>
			</cfif>
			<cfif structKeyExists(arguments,"orderby")>
				ORDER BY #arguments.orderby#
			</cfif>
		</cfquery>
		<cfreturn tmpQry>
	</cffunction>

</cfcomponent>