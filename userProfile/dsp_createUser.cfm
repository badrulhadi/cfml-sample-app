<cfparam name="attributes.alert" default="#structNew()#">

<!--- ------------- QUERY DATA ------------- --->

<cfquery name="q_role">
    SELECT iRoleID, vaRoleName
    FROM Roles WITH (NOLOCK)
    WHERE siStatus = 0
</cfquery>


<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h2 class="mt-5">Create New User</h2>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <div class="card mt-4">
        <div class="card-body">
            <cfoutput>
            <form 
                action="#application.APP_PATH#index.cfm?appmodule=User&appaction=act_createUser" 
                method="POST">

                <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

                <div class="row mb-3">
                    <label for="username" class="col-sm-2 col-form-label">Username</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="email" class="col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-6">
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="role" class="col-sm-2 col-form-label">Role</label>
                    <div class="col-sm-6">
                        <select class="form-control" id="role" name="role" required multiple>
                            <cfloop query="q_role">
                                <option value="#encodeForHTMLAttribute( iRoleID )#">#encodeForHTML( vaRoleName )#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a  href="#application.APP_PATH#index.cfm?appmodule=User&appaction=act_listUser"
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