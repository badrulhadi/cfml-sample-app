<cfparam name="attributes.q_role" default="">
<cfparam name="attributes.alert" default="#structNew()#">

<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h2 class="mt-5">Role </h2>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <!--- -------------------- ROLE FILTER ------------------- --->
    <div class="card mt-4">
        <div class="card-header">
            Filter
        </div>
        <div class="card-body">
            <cfoutput>
            <form 
                action="#application.APP_PATH#index.cfm?appmodule=Role&appaction=act_listRole" 
                method="POST"
                class="form-inline" >

                <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

                <label class="sr-only" for="roleName">Role Name</label>
                <div class="input-group input-group-sm my-1 mr-sm-2">
                    <div class="input-group-prepend">
                    <div class="input-group-text">@</div>
                    </div>
                    <input type="text" class="form-control form-control-sm" id="roleName" name="roleName" placeholder="role name">
                </div>


                <label class="my-1 mr-2" for="status">Status</label>
                <select class="form-control form-control-sm my-1 mr-2" id="status" name="status">
                    <option selected></option>
                    <option value="0">ACTIVE</option>
                    <option value="1">INACTIVE</option>
                </select>
                
                <button type="submit" class="btn btn-primary btn-sm mb-1">Apply</button>
                <a  class="btn btn-primary btn-sm mb-1 ml-2"
                    href="#application.APP_PATH#index.cfm?appmodule=Role&appaction=dsp_createRole" 
                    >Create Role
                </a>
            </form>
            </cfoutput>
        </div>
    </div>

    
    <!--- -------------------- LIST OF ROLE ------------------- --->
    <cfif isValid("query", attributes.q_role)>
        <div class="card mt-4">
            <div class="card-body">
                
                <cfif attributes.q_role.recordCount eq 0>
                    <cfmodule 
                        template="/template/alertMessage.cfm" 
                        type="secondary"
                        message="No record found"
                        >
                </cfif>
                
                <table class="table table-sm table-bordered table-hover">
                    <thead class="table-secondary">
                        <tr>
                            <th scope="col">Role Name</th>
                            <th scope="col">Status</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfoutput query="attributes.q_role">
                            <tr>
                                <td>#encodeForHTML( vaRoleName )#</td>
                                <td>
                                    <cfif siStatus eq 0>
                                        <span class="badge bg-success">ACTIVE</span>
                                    <cfelseif siStatus eq 1>
                                        <span class="badge bg-secondary">INACTIVE</span>
                                    </cfif>
                                </td>
                                <td>
                                    <a href="#application.APP_PATH#index.cfm?appmodule=Role&appaction=dsp_showRole&roleid=#encodeForURL( iRoleID )#" 
                                        class="btn btn-info btn-sm" 
                                        role="button" 
                                        aria-pressed="true">
                                        View
                                    </a>
                                </td>
                            </tr>
                        </cfoutput>

                    </tbody>
                </table>
            </div>
        </div>
    </cfif>

</div>

</main>

<cfmodule template="/template/footer.cfm">