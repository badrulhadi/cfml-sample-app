<cfparam name="form.username" default="">
<cfparam name="form.email" default="">
<cfparam name="form.role" default="">
<cfparam name="form.status" default="">


<!--- validate user input --->
<cfif len(form.username) eq 0>
	<cfset session.alertType = "error">
	<cfset session.alertMessage = "Username cannot be empty">
</cfif>

<cfif len(form.email) eq 0>
	<cfset session.alertType = "error">
	<cfset session.alertMessage = "Email cannot be empty">
</cfif>

<cfif len(form.role) eq 0>
	<cfset session.alertType = "error">
	<cfset session.alertMessage = "Role cannot be empty">
</cfif>

<cfif len(form.email) neq 0 and not isValid('email', form.email)>
	<cfset session.alertType = "error">
	<cfset session.alertMessage = "Must use valid email">
</cfif>

<!--- TODO: check is username and email already exist--->


<!--- Save Data --->
<cfif not structKeyExists(session, "alertType") or len(session.alertType) eq 0 >

    <cfquery name="q_insertUser" datasource="#application.APP_DSN#">
        UPDATE Users
        SET vaUsername = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_nvarchar">,
            vaEmail = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_nvarchar">,
            vaRole = <cfqueryparam value="#form.role#" cfsqltype="cf_sql_nvarchar">,
            siStatus = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">,
            iModifiedBy = <cfqueryparam value="#session.user.userID#" cfsqltype="cf_sql_integer">,
            dtModifiedOn = GETDATE()
        WHERE iUserID = <cfqueryparam value="#form.userID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfset session.alertType = "success">
    <cfset session.alertMessage = "User updated succesfully">

    <cflocation 
        url="#application.APP_PATH#/userProfile/dsp_listUser.cfm" 
        addtoken="false">
</cfif>

<!------------- TRY AGAIN ------------->
<cfmodule template="dsp_updateUser.cfm">