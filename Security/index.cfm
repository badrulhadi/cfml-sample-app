<cfparam name="attributes.appaction" default="">

<cfif NOT structKeyExists( session, 'vars')>
	<cfthrow TYPE="EX_SECFAILED" ErrorCode="NOLOGIN">
</cfif>

<cfif not request.helper.hasPermission( 'manageSecurityPolicy' )>
	<cfthrow TYPE="EX_SECFAILED" ErrorCode="ACCESDENIED">
</cfif>

<cfswitch expression=#attributes.appaction#>

	<cfcase value="dsp_securityPolicy">
		<cfmodule template="dsp_securityPolicy.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_securityPolicy">
		<cfmodule template="act_securityPolicy.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfdefaultcase>
		<cfthrow TYPE="EX_SECFAILED" ErrorCode="NODIRECT">
	</cfdefaultcase>
</cfswitch>
