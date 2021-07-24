<cfparam name="form.currentPassword" default="">
<cfparam name="form.newPassword" default="">
<cfparam name="form.newPasswordConfirm" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">


<cfset security = new component.Security()> 
<cfset minPasswordLength = security.getSecurityPolicy('minPasswordLength')>

<!--- validate user input --->

<cfif len(form.currentPassword) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Current password cannot be empty">
</cfif>

<cfif len(form.newPassword) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "New password cannot be empty">
</cfif>

<cfif len(form.newPasswordConfirm) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Confirm new password cannot be empty">
</cfif>

<cfif compare(form.newPassword, form.newPasswordConfirm) neq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "New password did not match">
</cfif>

<cfif compare(form.newPassword, form.currentPassword) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "New password cannot be same as current password">
</cfif>

<cfif len(form.newPassword) lt minPasswordLength>
	<cfset alert.type = "error">
	<cfset alert.message = "New password cannot be less than #minPasswordLength# characters long">
</cfif>


<cfif len(alert.type) eq 0 >
    <cfquery name="q_getPassword">
        SELECT vaPassword, vaSalt
        FROM Users
        WHERE iUserID = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer ">
    </cfquery>

    <cfset wrongPassword = not security.verifyPassword( 
        form.currentPassword, 
        q_getPassword.vaPassword, 
        q_getPassword.vaSalt 
    )> 

    <cfif wrongPassword >
        <cfset session.vars.alertType = "error">
        <cfset session.vars.alertMessage = "Wrong current password">
        
        <cflocation url="#application.APP_PATH#index.cfm?appmodule=Authentication&appaction=dsp_changePassword" addtoken="false">
    </cfif>

    <cfset newSalt = security.generateSalt() >
    <cfset newHashPassword = security.hashPassword( form.newPassword, newSalt )>

    <cfquery name="q_changePassword">
        UPDATE Users
        SET vaPassword = <cfqueryparam value="#newHashPassword#" cfsqltype="cf_sql_nvarchar">
            , vaSalt = <cfqueryparam value="#newSalt#" cfsqltype="cf_sql_nvarchar">
            , dtModifiedOn = GETDATE()
            , iModifiedBy = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
        WHERE iUserID = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfset session.vars.alertType = "success">
    <cfset session.vars.alertMessage = "Change password successful">

    <cfif structKeyExists( session.vars, "firstTimeLogin" )>
        <cfquery name="q_updateUser">
            UPDATE Users 
            SET iLoginFailedCount = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
                , dtLastLogin = GETDATE()
                , siStatus = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
            WHERE iUserID = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cflocation url="#application.APP_PATH#index.cfm?appmodule=Authentication&appaction=login" addtoken="false">
    </cfif>

    <cflocation url="#application.APP_PATH#index.cfm?appmodule=Authentication&appaction=dsp_changePassword" addtoken="false">
</cfif>


<cfmodule 
	template="#application.APP_PATH#index.cfm"
	appmodule="Authentication"
	appaction="dsp_changePassword"
	alert="#alert#">
