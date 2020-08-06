<cfmodule template="#application.APP_PATH#/customTags/header.cfm">


<cfparam name="form.email" default="">
<cfparam name="form.username" default="">
<cfparam name="form.role" default="">

<!--- ----------- QUERY get data ----------- --->
<cfquery name="q_user" datasource="#application.APP_DSN#">
    SELECT iUserID, vaUsername, vaEmail, vaRole, siStatus
    FROM Users
    WHERE  1=1

    <cfif session.user.role neq "administrator">
        AND iUserID = <cfqueryparam value="#session.user.userID#" cfsqltype="cf_sql_integer">
    </cfif>

    <cfif len(form.username) neq 0>
        AND vaUserName LIKE <cfqueryparam value="%#form.username#%" cfsqltype="cf_sql_nvarchar">
    </cfif>

    <cfif len(form.email) neq 0>
        AND vaEmail LIKE <cfqueryparam value="%#form.email#%" cfsqltype="cf_sql_nvarchar">
    </cfif>

    <cfif len(form.role) neq 0>
        AND vaRole LIKE <cfqueryparam value="%#form.role#%" cfsqltype="cf_sql_nvarchar">
    </cfif>
</cfquery>


<!--- -------------- DISPLAY -------------- --->
<div class="container">

    <div>
        <h2>User Profile</h2>
    </div>

    <cfmodule template="#application.APP_PATH#/customTags/alertMessage.cfm">

    <!--- -------------------- USER FILTER ------------------- --->
    <cfif session.user.role eq "administrator">
        <div class="card mt-4">
            <div class="card-header">
                Filter
            </div>
            <div class="card-body">
                <cfoutput>
                <form 
                    action="" 
                    method="POST"
                    class="form-inline" >

                    <label class="sr-only" for="username">Username</label>
                    <div class="input-group input-group-sm my-1 mr-sm-2">
                        <div class="input-group-prepend">
                        <div class="input-group-text">@</div>
                        </div>
                        <input type="text" class="form-control form-control-sm" id="username" name="username" placeholder="Username">
                    </div>

                    <label class="sr-only" for="username">Email</label>
                    <div class="input-group input-group-sm my-1 mr-sm-2">
                        <div class="input-group-prepend">
                        <div class="input-group-text">@</div>
                        </div>
                        <input type="text" class="form-control form-control-sm" id="username" name="username" placeholder="Email">
                    </div>

                    <label class="my-1 mr-2" for="role">Role</label>
                    <select class="form-control form-control-sm my-1 mr-2" id="role" name="role">
                        <option selected></option>
                        <option value="Administrator">Administrator</option>
                        <option value="User">User</option>
                    </select>
                    
                    <button type="submit" class="btn btn-primary btn-sm mb-1 mr-2">Apply</button>
                    <a href="#application.APP_PATH#/userProfile/dsp_createUser.cfm" 
                        type="submit" 
                        class="btn btn-primary btn-sm mb-1">Create User
                    </a>
                </form>
                </cfoutput>
            </div>
        </div>
    </cfif>

    
    <!--- -------------------- LIST OF USER ------------------- --->
    <div class="card mt-4">
        <div class="card-body">
            
            <table class="table table-sm table-bordered table-hover">
                <thead class="table-secondary">
                    <tr>
                        <th scope="col">Email</th>
                        <th scope="col">Username</th>
                        <th scope="col">Role</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query="q_user">
                        <tr>
                            <td>#encodeForHTML(vaEmail)#</td>
                            <td>
                                <a href="#application.APP_PATH#/userProfile/dsp_editUser.cfm?userID=#iUserID#" >
                                    #vaUserName#
                                </a>
                            </td>
                            <td>#vaRole#</td>
                            <td>
                                <cfif siStatus eq 0>
                                    <span class="badge badge-success">ACTIVE</span>
                                <cfelse>
                                    <span class="badge badge-secondary">INACTIVE</span>
                                </cfif>
                            </td>

                        </tr>
                    </cfoutput>

                </tbody>
            </table>
        </div>
    </div>

</div>
    
<cfmodule template="#application.APP_PATH#/customTags/footer.cfm">