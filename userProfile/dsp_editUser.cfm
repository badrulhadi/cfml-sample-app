<cfmodule template="#application.APP_PATH#/customTags/header.cfm">


<!--- ------------- QUERY DATA ------------- --->
<cfquery name="q_user" datasource="#application.APP_DSN#">
    SELECT vaUsername, vaEmail, vaRole, siStatus
    FROM Users
    WHERE iUserID = <cfqueryparam value="#url.userID#" cfsqltype="cf_sql_integer">
</cfquery>


<!--- ------------- DISPLAY ------------- --->

<div class="container">

    <div>
        <h2>User Profile</h2>
    </div>

    <cfmodule template="#application.APP_PATH#/customTags/alertMessage.cfm">

    <div class="card mt-4">
        <div class="card-body">

            <cfoutput query="q_user">
            <form 
                action="#application.APP_PATH#/userProfile/act_updateUser.cfm" 
                method="POST">

                <input type="hidden" id="userID" name="userID" value="#url.userID#">
                
                <div class="form-group row">
                    <label for="username" class="col-sm-2 col-form-label">Username</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="username" name="username" value="#vaUsername#"autocomplete="off" required >
                    </div>
                </div>

                <div class="form-group row">
                    <label for="email" class="col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-6">
                        <input type="email" class="form-control" id="email" name="email" value="#vaEmail#" autocomplete="off" required>
                    </div>
                </div>

                <cfif session.user.role eq "Administrator" > <!--- ONLY ADMINISTRATOR VIEW --->
                
                    <div class="form-group row">
                        <label for="role" class="col-sm-2 col-form-label">Role</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="role" name="role" required>
                                <option <cfif vaRole eq "Administrator">selected</cfif> value="Administrator">Administrator</option>
                                <option <cfif vaRole eq "User">selected</cfif> value="User">User</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="status" class="col-sm-2 col-form-label">Status</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="status" name="status" required>
                                <option <cfif siStatus eq 1>selected</cfif> value="1">INACTIVE</option>
                                <option <cfif siStatus eq 0>selected</cfif> value="0">ACTIVE</option>
                            </select>
                        </div>
                    </div>

                <cfelse>
                    <div class="form-group row">
                        <label for="role" class="col-sm-2 col-form-label">Role</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="role" name="role" value="#vaRole#"  readonly>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="status" class="col-sm-2 col-form-label">Status</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="status" name="status" readonly>
                                <option <cfif siStatus eq 1>selected</cfif> value="1">INACTIVE</option>
                                <option <cfif siStatus eq 0>selected</cfif> value="0">ACTIVE</option>
                            </select>
                        </div>
                    </div>
                </cfif>
                
                <div class="form-group row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Update</button>
                        <a href="#application.APP_PATH#/userProfile/dsp_listUser.cfm" class="btn btn-secondary">Cancel</a>
                    </div>
                </div>
            </form>
            </cfoutput>
        </div>
    </div>
</div>

<cfmodule template="#application.APP_PATH#/customTags/footer.cfm">