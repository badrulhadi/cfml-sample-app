<cfparam name="attributes.appaction" default="">


<cfif NOT structKeyExists( session, 'vars')>
	<cfthrow TYPE="EX_SECFAILED" ErrorCode="NOLOGIN">
</cfif>


<cfswitch expression=#attributes.appaction#>
	<cfcase value="dsp_comment">
		<cfmodule template="dsp_comment.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_comment">
		<cfmodule template="act_comment.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfdefaultcase>
		<cfthrow TYPE="EX_SECFAILED" ErrorCode="NODIRECT">
	</cfdefaultcase>
</cfswitch>
