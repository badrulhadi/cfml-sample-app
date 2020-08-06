<cfparam name="form.username" default="">
<cfparam name="form.email" default="">
<cfparam name="form.role" default="">


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

    <!--- set temporary password --->
    <cfset tempPassword = "test123">
    <cfset tempPassword = hash( tempPassword, "SHA-512")>

    <cfquery name="q_insertUser" datasource="#application.APP_DSN#">
        INSERT INTO Users (
            vaUsername, vaEmail, vaPassword, vaRole, iCreateBy
        )
        VALUES (
            <cfqueryparam value="#form.username#" cfsqltype="cf_sql_nvarchar">,
            <cfqueryparam value="#form.email#" cfsqltype="cf_sql_nvarchar">,
            <cfqueryparam value="#tempPassword#" cfsqltype="cf_sql_nvarchar">,
            <cfqueryparam value="#form.role#" cfsqltype="cf_sql_nvarchar">,
            <cfqueryparam value="#session.user.userID#" cfsqltype="cf_sql_integer">
        )
    </cfquery>

    <cfset session.alertType = "success">
    <cfset session.alertMessage = "User created succesfully">

    <cflocation 
        url="#application.APP_PATH#/userProfile/dsp_listUser.cfm" 
        addtoken="false">
</cfif>

<!------------- TRY AGAIN ------------->
<cfmodule template="dsp_createUser.cfm">