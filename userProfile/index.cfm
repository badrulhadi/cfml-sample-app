<cfparam name="attributes.appaction" default="">

<cfif NOT structKeyExists( session, 'vars')>
	<cfthrow TYPE="EX_SECFAILED" ErrorCode="NOLOGIN">
</cfif>

<cfswitch expression=#attributes.appaction#>
	<cfcase value="dsp_userProfile">
		<cfmodule template="dsp_userProfile.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="dsp_listUser">
		<cfmodule template="dsp_listUser.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_listUser">
		<cfif not request.helper.hasPermission( 'viewUser' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="act_listUser.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="dsp_showUser">
		<cfif not request.helper.hasPermission( 'viewUser' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="dsp_showUser.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="dsp_createUser">
		<cfif not request.helper.hasPermission( 'createUser' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="dsp_createUser.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_createUser">
		<cfif not request.helper.hasPermission( 'createUser' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="act_createUser.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_updateUser">
		<cfif not request.helper.hasPermission( 'updateUser' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="act_updateUser.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfdefaultcase>
		<cfdump var="lalala" abort>
		<cfthrow TYPE="EX_SECFAILED" ErrorCode="NODIRECT">
	</cfdefaultcase>
</cfswitch>
