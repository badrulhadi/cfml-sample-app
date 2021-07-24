<cfparam name="attributes.appaction" default="">

<cfif NOT structKeyExists( session, 'vars')>
	<cfthrow TYPE="EX_SECFAILED" ErrorCode="NOLOGIN">
</cfif>

<cfif not request.helper.hasPermission( 'manageRole' )>
	<cfthrow TYPE="EX_SECFAILED" ErrorCode="ACCESDENIED">
</cfif>


<cfswitch expression=#attributes.appaction#>
	<cfcase value="dsp_listRole">
		<cfmodule template="dsp_listRole.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_listRole">
		<cfmodule template="act_listRole.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="dsp_showRole">
		<cfmodule template="dsp_showRole.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="dsp_createRole">
		<cfmodule template="dsp_createRole.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_createRole">
		<cfmodule template="act_createRole.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_updateRole">
		<cfmodule template="act_updateRole.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfdefaultcase>
		<cfthrow TYPE="EX_SECFAILED" ErrorCode="NODIRECT">
	</cfdefaultcase>
</cfswitch>
