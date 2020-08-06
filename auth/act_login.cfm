<cfparam name="form.username" default="">
<cfparam name="form.password" default="">

<!--- 
    hash password. this is simple one for starter.
    proper password hashing should include salt and use slower hash algorithm
--->
<cfset hashPassword = hash(form.password, "SHA-512")>


<!--- check if user exist and password matched --->
<cfquery name="q_user" datasource="#application.APP_DSN#">
    SELECT iUserID, vaUsername, vaRole
    FROM Users
    WHERE vaUsername = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_nvarchar">
        AND vaPassword = <cfqueryparam value="#hashPassword#" cfsqltype="cf_sql_nvarchar">
</cfquery>


<!--- if user exist set session variables and redirect to homepage --->
<cfif q_user.recordCount eq 1>
    <cfset session.user = {}>
    <cfset session.user.userID = q_user.iUserID>
    <cfset session.user.role = q_user.vaRole>

    <cflocation url="#application.APP_PATH#/home/home.cfm" addtoken="true">
</cfif>


<!--- No user found / wrong password or username --->
<cfset alertType = "error">
<cfset alertMessage = "Invalid UserID or Password. Please try again.">

<cfmodule template="dsp_login.cfm" alertType="#alertType#" alertMessage="#alertMessage#">
