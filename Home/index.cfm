<cfparam name="attributes.appaction" default="">

<!--- <cfdump var="#session#" abort> --->
<cfif NOT structKeyExists( session, 'vars')>
	<cfthrow TYPE="EX_SECFAILED" ErrorCode="NOLOGIN">
</cfif>


<cfswitch expression=#attributes.appaction#>
	<cfcase value="dsp_home">
        <cfmodule template="dsp_home.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfdefaultcase>
		<cfthrow TYPE="EX_SECFAILED" ErrorCode="NODIRECT">
	</cfdefaultcase>
</cfswitch>
