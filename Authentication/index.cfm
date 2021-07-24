<cfparam name="attributes.appaction" default="">


<!--- <cfdump var="#session#" abort> --->

<cfswitch expression=#attributes.appaction#>
	<cfcase value="login">
		<cfmodule template="dsp_login.cfm" attributecollection="#attributes#">
	</cfcase>

	<cfcase value="authenticate">
		<cfmodule template="act_login.cfm" attributecollection="#attributes#">
	</cfcase>

	<cfcase value="logout">
		<cfmodule template="act_logout.cfm" attributecollection="#attributes#">
	</cfcase>

	<cfcase value="act_setSessionVars">
		<cfmodule template="act_setSessionVars.cfm" attributecollection="#attributes#">
	</cfcase>

	<cfcase value="dsp_changePassword">
		<cfmodule template="dsp_changePassword.cfm" attributecollection="#attributes#">
	</cfcase>

	<cfcase value="act_changePassword">
		<cfmodule template="act_changePassword.cfm" attributecollection="#attributes#">
	</cfcase>

	<cfdefaultcase>
		<cfthrow TYPE="EX_SECFAILED" ErrorCode="NODIRECT">
	</cfdefaultcase>
</cfswitch>
