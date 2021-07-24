<cfparam name="attributes.roleID" default="">
<cfparam name="attributes.alert" default="#structNew()#">

<!--- ------------- QUERY DATA ------------- --->
<cfquery name="q_role">
    SELECT iRoleID, vaRoleName, siStatus 
    FROM Roles WITH (NOLOCK)
    WHERE iRoleID = <cfqueryparam value="#attributes.roleID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name="q_rolePermission">
    SELECT iPermissionID
    FROM RolePermission WITH (NOLOCK)
    WHERE iRoleID = <cfqueryparam value="#attributes.roleID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name="q_permission">
    SELECT iPermissionID, vaPermissionName
    FROM Permission WITH (NOLOCK)
    WHERE siStatus = 0
</cfquery>

<cfset rolePermissions = valueList(q_rolePermission.iPermissionID)>


<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h2 class="mt-5">Role</h2>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <!---------------------------- ROLE INFORMATION ---------------------------->
    <cfoutput query="q_role">
    <div class="card mt-4">
        <div class="card-body">
            <form 
                action="#application.APP_PATH#index.cfm?appmodule=Role&appaction=act_updateRole" 
                method="POST">

                <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">
                <input type="hidden" name="roleID" value="#attributes.roleID#">

                <div class="row mb-3">
                    <label for="roleName" class="col-sm-2 col-form-label font-weight-bold">Role Name</label>
                    <div class="col-sm-4">
                        <span class="align-middle pt-1">
                            #encodeForHTML( vaRoleName )#
                        </span>
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="status" class="col-sm-2 col-form-label font-weight-bold">Status</label>
                    <div class="col-sm-2">
                        <select 
                            class="form-control form-control-sm" 
                            id="status" 
                            name="status" >

                            <option value="0" <cfif siStatus eq 0>selected</cfif> >ACTIVE</option>
                            <option value="1" <cfif siStatus eq 1>selected</cfif> >INACTIVE</option>
                        </select>
                    </div>
                </div>
                
                <div class="row mb-3">
                    <div class="col-sm-2 font-weight-bold">Permissions</div>
                    <div class="col-sm-10">

                        <cfloop query="q_permission">
                            <div class="form-check">
                                <input 
                                    class="form-check-input" 
                                    type="checkbox" 
                                    name="permission"
                                    id="#encodeForHTML( vaPermissionName )#" 
                                    value="#encodeForHTML( iPermissionID )#"
                                    <cfif listFind( rolePermissions, iPermissionID)> checked </cfif>
                                    >
                                <label class="form-check-label" for="#encodeForHTML( vaPermissionName )#">
                                    #encodeForHTML( vaPermissionName )#
                                </label>
                            </div>
                        </cfloop>

                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a  href="#application.APP_PATH#index.cfm?appmodule=Role&appaction=act_listRole"
                            class="btn btn-secondary">
                            Cancel
                        </a>
                    </div>
                </div>

            </form>
        </div>
    </div>
    </cfoutput>


</div>

</main>

<cfmodule template="/template/footer.cfm">