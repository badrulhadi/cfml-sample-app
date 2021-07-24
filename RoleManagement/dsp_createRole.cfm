<cfparam name="attributes.alert" default="#structNew()#">

<!--- ------------- QUERY DATA ------------- --->

<cfquery name="q_permission">
    SELECT iPermissionID, vaPermissionName
    FROM Permission WITH (NOLOCK)
    WHERE siStatus = 0
</cfquery>


<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h2 class="mt-5">Create New Role</h2>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <div class="card mt-4">
        <div class="card-body">
            <cfoutput>
            <form 
                action="#application.APP_PATH#index.cfm?appmodule=Role&appaction=act_createRole" 
                method="POST">

                <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

                <div class="row mb-3">
                    <label for="roleName" class="col-sm-2 col-form-label">Role Name</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="roleName" name="roleName" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-sm-2">Permissions</div>
                    <div class="col-sm-10">

                        <cfloop query="q_permission">
                            <div class="form-check">
                                <input 
                                    class="form-check-input" 
                                    type="checkbox" 
                                    name="permission"
                                    id="#encodeForHTML( vaPermissionName )#" 
                                    value="#encodeForHTML( iPermissionID )#" 
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
            </cfoutput>
        </div>
    </div>
</div>

</main>

<cfmodule template="/template/footer.cfm">