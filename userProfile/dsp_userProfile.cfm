<cfparam name="attributes.userID" default="">
<cfparam name="attributes.alert" default="#structNew()#">

<!--- ------------- QUERY DATA ------------- --->
<cfquery name="q_user">
    SELECT iUserID, vaUsername, vaEmail, siStatus 
    FROM Users WITH (NOLOCK)
    WHERE iUserID = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name="q_userRole">
    SELECT R.iRoleID, R.vaRoleName
    FROM UserRole UR WITH (NOLOCK)
        INNER JOIN Roles R ON R.iRoleID = UR.iRoleID 
    WHERE UR.iUserID = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfset userRoles = valueList(q_userRole.vaRoleName)>


<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h2 class="mt-5">User Profile</h2>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <!---------------------------- User Profile ---------------------------->
    <cfoutput query="q_user">
    <div class="card mt-4">
        <div class="card-body">
            <form 
                action="#application.APP_PATH#index.cfm?appmodule=UserProfile&appaction=act_updateUser" 
                method="POST">

                <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">
                <input type="hidden" name="userID" value="#attributes.userID#">

                <div class="row mb-1">
                    <label for="issueID" class="col-sm-2 col-form-label font-weight-bold">Username</label>
                    <div class="col-sm-4">
                        <span class="align-middle pt-1">
                            #encodeForHTML( vaUsername )#
                        </span>
                    </div>
                </div>

                <div class="row mb-1">
                    <label for="revision" class="col-sm-2 col-form-label font-weight-bold">Email</label>
                    <div class="col-sm-4">
                        <span class="align-middle pt-1">
                            #encodeForHTML( vaEmail )#
                        </span>
                    </div>
                </div>

                <div class="row mb-1">
                    <label for="role" class="col-sm-2 col-form-label font-weight-bold">Role</label>
                    <div class="col-sm-4">
                        <cfloop list="#userRoles#" index="role">
                            <div class="align-middle pt-1">
                                #encodeForHTML( role )#
                            </div>
                        </cfloop>
                    </div>
                </div>

                <div class="row mb-1">
                    <label for="status" class="col-sm-2 col-form-label font-weight-bold">Status</label>
                    <div class="col-sm-2">
                        <cfif siStatus eq 0>
                            <div class="align-middle pt-1">
                                ACTIVE
                            </div>
                        </cfif>
                    </div>
                </div>

                <div class="row mb-1">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <a  href="#application.APP_PATH#index.cfm?appmodule=Root&appaction=dsp_home"
                            class="btn btn-primary">
                            Back Home
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