
<cfparam name="attributes.appmodule" default="">
<cfparam name="attributes.appaction" default="">

<cfif getHttpRequestData().method eq "POST">
	<cfif not structKeyExists( form, "formToken")>
		<cfthrow TYPE="EX_SECFAILED" ErrorCode="CSRFATTACK">
	</cfif>

	<cfif !csrfVerifyToken( form.formToken )>
		<cfheader statuscode="403">
	</cfif>
</cfif>

<cfswitch expression=#attributes.appmodule#>
	
	<!--- All Home related pages go here--->
	<cfcase value="Home">
		<cfinclude template="Home/index.cfm">
	</cfcase>

	<!--- All Authentication related pages go here--->
	<cfcase value="Authentication">
		<cfinclude template="Authentication/index.cfm">
	</cfcase>

	<!--- All Post related pages go here--->
	<cfcase value="Post">
		<cfinclude template="Post/index.cfm">
	</cfcase>

	<!--- All Comment related pages go here--->
	<cfcase value="Comment">
		<cfinclude template="Comment/index.cfm">
	</cfcase>

	<!--- All Userprofile related pages go here--->
	<cfcase value="User">
		<cfinclude template="UserProfile/index.cfm">
	</cfcase>

	<!--- All Role related pages go here--->
	<cfcase value="Role">
		<cfinclude template="RoleManagement/index.cfm">
	</cfcase>

	<!--- All Security related pages go here--->
	<cfcase value="Security">
		<cfinclude template="Security/index.cfm">
	</cfcase>
	
	<!--- The default login page --->
	<cfdefaultcase>

		<cfif structKeyExists( session, 'vars')>
			<cflocation 
				url="#application.APP_URL#index.cfm?appmodule=Home&appaction=dsp_home" 
				addtoken="false"
				>
		</cfif>

		<cflocation 
			url="#application.APP_URL#index.cfm?appmodule=Authentication&appaction=login" 
			addtoken="false"
			>
	</cfdefaultcase>
</cfswitch>