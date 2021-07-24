<cfparam name="form.rolename" default="">
<cfparam name="form.permission" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">


<!--- validate user input --->

<cfif len(form.rolename) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Role name cannot be empty">
</cfif>

<cfif len(form.permission) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Please select permission">
</cfif>


<cfif len(alert.type) eq 0 >
    <cfquery name="q_checkRoleNameExist">
        SELECT vaRoleName
        FROM Roles WITH (NOLOCK)
        WHERE vaRoleName = <cfqueryparam value="#form.roleName#" cfsqltype="cf_sql_nvarchar">
    </cfquery>

    <cfif q_checkRoleNameExist.recordCount gt 0>
        <cfset alert.type = "error">
        <cfset alert.message = "That Role name already exist">
    </cfif>
</cfif>


<!--- Save Data --->
<cfif len(alert.type) eq 0 >

    <cfset rolePermissions = listToArray(form.permission)>

    <cftransaction>
        <cfquery name="q_createRole" result="qResult">
            INSERT INTO Roles (
                vaRoleName, iCreatedBy
            )
            VALUES (
                <cfqueryparam value="#form.roleName#" cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
            )
        </cfquery>

        <cfquery name="q_insertRolePermission">
            INSERT INTO RolePermission (
                iRoleID, iPermissionID, iCreatedBy
            )
            VALUES 
            <cfloop  index="i" from="1" to="#arrayLen(rolePermissions)#">
            (
                <cfqueryparam value="#qResult.generatedKey#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#rolePermissions[i]#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
            )
            <cfif i lt arrayLen( rolePermissions )> , </cfif>
            </cfloop>
        </cfquery>
    </cftransaction>

</cfif>


<cfif len(alert.type) eq 0 >
    <cfset session.vars.alertType = "success">
    <cfset session.vars.alertMessage = "Role created succesfully">
    
    <!--- <cfmodule 
        template="#application.APP_PATH#Notification/reviewNotification.cfm" 
        action="create"
        reviewID="#reviewID#"> --->

    <cflocation 
        url="#application.APP_PATH#index.cfm?appmodule=Role&appaction=act_listRole" 
        addtoken="false">
</cfif>

<!------------- TRY AGAIN ------------->
<cfmodule template="dsp_createRole.cfm" alert="#alert#">
