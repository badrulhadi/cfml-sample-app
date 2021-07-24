
<cfparam name="form.roleID" default="">
<cfparam name="form.permission" default="">
<cfparam name="form.status" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">


<!--- check permission --->
<!--- <cfmodule 
    template="#application.APP_PATH#CustomTags/checkPermission.cfm"
    fileID="#form.fileID#"
    returnVar="isReviewer"
    > --->

<!--- <cfif not isReviewer>
    <cfset alert.type = "error">
	<cfset alert.message = "Only Reviewer can update.">
</cfif> --->


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

    <cfif len(form.permission) eq 0>
        <cfset alert.type = "error">
        <cfset alert.message = "Please select permission">
    </cfif>
</cfif>


<!--- Save Data --->
<cfif len(alert.type) eq 0 >

    <cfset rolePermissions = listToArray(form.permission)>

    <cftransaction>
        <cfquery name="q_updateRole">
            UPDATE Roles
            SET siStatus = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">
                , dtModifiedOn = GETDATE()
                , iModifiedBy = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
            WHERE iRoleID = <cfqueryparam value="#form.roleID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfquery name="q_deleteRolePermission">
            DELETE FROM RolePermission 
            WHERE iRoleID = <cfqueryparam value="#form.roleID#" cfsqltype="cf_sql_integer">;
        </cfquery>

        <cfquery name="q_insertRolePermission">
            INSERT INTO RolePermission (
                iRoleID, iPermissionID, iCreatedBy
            )
            VALUES 
            <cfloop  index="i" from="1" to="#arrayLen(rolePermissions)#">
            (
                <cfqueryparam value="#form.roleID#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#rolePermissions[i]#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
            )
            <cfif i lt arrayLen( rolePermissions )> , </cfif>
            </cfloop>
        </cfquery>


        <!--- TODO: update userRole when role is inactive --->
    
    </cftransaction>

    <cfset session.vars.alertType = "success">
    <cfset session.vars.alertMessage = "Role updated succesfully">

    <cflocation 
        url="#application.APP_PATH#index.cfm?appmodule=Role&appaction=dsp_showRole&roleID=#form.roleID#" 
        addtoken="false">
</cfif>

<!------------- TRY AGAIN ------------->
<cfmodule template="dsp_showRole.cfm" alert="#alert#" roleID="#form.roleID#">