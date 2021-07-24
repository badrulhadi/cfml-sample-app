<cfparam name="attributes.userID" default="">
<cfparam name="attributes.alert" default="#structNew()#">

<!--- ------------- QUERY DATA ------------- --->
<cfquery name="q_user">
    SELECT iUserID, vaUsername, vaEmail, siStatus 
    FROM Users WITH (NOLOCK)
    WHERE iUserID = <cfqueryparam value="#attributes.userID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name="q_userRole">
    SELECT iRoleID
    FROM UserRole WITH (NOLOCK)
    WHERE iUserID = <cfqueryparam value="#attributes.userID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name="q_role">
    SELECT iRoleID, vaRoleName
    FROM Roles WITH (NOLOCK)
    WHERE siStatus = 0
</cfquery>

<cfset userRoles = valueList(q_userRole.iRoleID)>


<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h2 class="mt-5">User Profile</h2>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <!---------------------------- USER INFORMATION ---------------------------->
    <cfoutput query="q_user">
    <div class="card mt-4">
        <div class="card-body">
            <form 
                action="#application.APP_PATH#index.cfm?appmodule=User&appaction=act_updateUser" 
                method="POST">

                <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">
                <input type="hidden" name="userID" value="#attributes.userID#">

                <div class="row mb-3">
                    <label for="issueID" class="col-sm-2 col-form-label font-weight-bold">Username</label>
                    <div class="col-sm-4">
                        <span class="align-middle pt-1">
                            #encodeForHTML( vaUsername )#
                        </span>
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="revision" class="col-sm-2 col-form-label font-weight-bold">Email</label>
                    <div class="col-sm-4">
                        <span class="align-middle pt-1">
                            #encodeForHTML( vaEmail )#
                        </span>
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="role" class="col-sm-2 col-form-label font-weight-bold">Role</label>
                    <div class="col-sm-2">
                        <select 
                            class="form-select" 
                            id="role" 
                            name="role" 
                            multiple>
                            <cfloop query="q_role">
                                <option 
                                    value="#encodeForHTMLAttribute( iRoleID )#"
                                    <cfif listFind( userRoles, iRoleID)> selected </cfif>
                                    >
                                    #encodeForHTML( vaRoleName )#
                                </option>
                            </cfloop>
                        </select>
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
                    <div class="col-sm-2 font-weight-bold"></div>
                    <div class="col-sm-10">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="resetPassword" id="resetPassword" value="1">
                            <label class="form-check-label" for="resetPassword">
                                Reset Password
                            </label>
                        </div>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <cfif request.helper.hasPermission( 'createUser' )>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </cfif>
                        <a  href="#application.APP_PATH#index.cfm?appmodule=User&appaction=act_listUser"
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