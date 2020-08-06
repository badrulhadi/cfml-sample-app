<cfparam name="form.currentPassword" default="">
<cfparam name="form.newPassword" default="">
<cfparam name="form.newPasswordConfirm" default="">


<!--- validate user input --->
<!--- TODO: validate all form field is not submitted empty --->
<!--- TODO: check if newPassword & newPasswordConfirm matched --->
<!--- TODO: check if currentPassword correct --->


<!--- TODO: Hash new password--->


<!--- If all validation correct then update new password in database --->
<cfif not structKeyExists(session, "alertType") or len(session.alertType) eq 0 >

    <cfquery name="q_updateUser" datasource="#application.APP_DSN#">
        UPDATE Users
        SET vaPassword = ''
        WHERE iUserID
    </cfquery>

    <cfset session.alertType = "success">
    <cfset session.alertMessage = "Succesfully change password">

    <cflocation 
        url="#application.APP_PATH#/auth/act_logout.cfm" 
        addtoken="false">
</cfif>

<!------------- TRY AGAIN ------------->
<cfmodule template="dsp_changePassword.cfm">