
<cfparam name="form.userID" default="">
<cfparam name="form.role" default="">
<cfparam name="form.status" default="">
<cfparam name="form.resetPassword" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">


<!--- validate user input --->
<cfif len(alert.type) eq 0 >
    <cfif len(form.status) neq 0 and not arrayFind([1, 0], form.status)>
        <cfset alert.type = "error">
        <cfset alert.message = 'Status can only be "ACTIVE" or "INACTIVE"'>
    </cfif>

    <cfif len(form.status) eq 0>
        <cfset alert.type = "error">
        <cfset alert.message = "Status cannot be empty">
    </cfif>

    <cfif len(form.role) eq 0>
        <cfset alert.type = "error">
        <cfset alert.message = "Role cannot be empty">
    </cfif>
</cfif>


<!--- Save Data --->
<cfif len(alert.type) eq 0 >

    <cfif len( form.resetPassword ) neq 0>
        <cfset security = new component.Security()> 
        <cfset tempPassword = security.generatePassword( 10 ) >
        <cfset salt = security.generateSalt() >
        <cfset hashTempPassword = security.hashPassword( tempPassword, salt )>
    </cfif>

    <cfset userRoles = listToArray(form.role)>

    <cftransaction>
        <cfquery name="q_updateUser">
            UPDATE Users
            SET siStatus = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">
            
            <cfif len( form.resetPassword ) neq 0>
                , vaPassword = <cfqueryparam value="#hashTempPassword#" cfsqltype="cf_sql_nvarchar">
                , vaSalt = <cfqueryparam value="#hashTempPassword#" cfsqltype="cf_sql_nvarchar">
            </cfif>
            
                , dtModifiedOn = GETDATE()
                , iModifiedBy = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
            WHERE iUserID = <cfqueryparam value="#form.userID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfquery name="q_deleteUserRole">
            DELETE FROM UserRole 
            WHERE iUserID = <cfqueryparam value="#form.userID#" cfsqltype="cf_sql_integer">;
        </cfquery>

        <cfquery name="q_insertUserRole">
            INSERT INTO UserRole (
                iUserID, iRoleID, iCreatedBy
            )
            VALUES 
            <cfloop  index="i" from="1" to="#arrayLen(userRoles)#">
            (
                <cfqueryparam value="#form.userID#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#userRoles[i]#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
            )
            <cfif i lt arrayLen( userRoles )> , </cfif>
            </cfloop>
        </cfquery>
    
    </cftransaction>

    <cfset session.vars.alertType = "success">
    <cfset session.vars.alertMessage = "User updated succesfully">

    <cfif len( form.resetPassword ) neq 0>
        <cfmodule 
            template="#application.APP_PATH#Notification/passwordResetNotification.cfm" 
            userID="#form.userID#"
            tempPassword="#tempPassword#">
    </cfif>

    <cflocation 
        url="#application.APP_PATH#index.cfm?appmodule=User&appaction=dsp_showUser&userID=#form.userID#" 
        addtoken="false">
</cfif>

<!------------- TRY AGAIN ------------->
<cfmodule template="dsp_showUser.cfm" alert="#alert#" userID="#form.userID#">