<cfparam name="attributes.userID" default="">
<cfparam name="attributes.firstTimeLogin" default="false">

<cfset session.vars = {}>
<cfset session.vars.userID = attributes.userID>
<cfset session.vars.roles = []>
<cfset session.vars.permissions = []>

<cfif attributes.firstTimeLogin>
    <cfset session.vars.firstTimeLogin = true>
<cfelse>
    <cfquery name="q_getRole">
        SELECT DISTINCT R.vaRoleName
        FROM Roles R WITH (NOLOCK)
            INNER JOIN UserRole UR ON UR.iRoleID = R.iRoleID 
        WHERE UR.iUserID = <cfqueryparam value="#attributes.userID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfquery name="q_getPermission">
        SELECT DISTINCT P.vaPermissionName
        FROM Permission P WITH (NOLOCK)
            INNER JOIN RolePermission RP ON RP.iPermissionID = P.iPermissionID 
            INNER JOIN UserRole UR ON UR.iRoleID = RP.iRoleID 
        WHERE UR.iUserID = <cfqueryparam value="#attributes.userID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfset session.vars.roles = listToArray(valueList( q_getRole.vaRoleName ))>
    <cfset session.vars.permissions = listToArray(valueList( q_getPermission.vaPermissionName ))>
</cfif> 