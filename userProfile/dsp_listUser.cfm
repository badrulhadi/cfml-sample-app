<cfparam name="attributes.q_user" default="">
<cfparam name="attributes.alert" default="#structNew()#">

<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h2 class="mt-5">User </h2>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <!--- -------------------- USER FILTER ------------------- --->
    <div class="card mt-4">
        <div class="card-header">
            Filter
        </div>
        <div class="card-body">
            <cfoutput>
            <form 
                action="#application.APP_PATH#index.cfm?appmodule=User&appaction=act_listUser" 
                method="POST"
                class="form-inline" >

                <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

                <label class="sr-only" for="username">Username</label>
                <div class="input-group input-group-sm my-1 mr-sm-2">
                    <div class="input-group-prepend">
                    <div class="input-group-text">@</div>
                    </div>
                    <input type="text" class="form-control form-control-sm" id="username" name="username" placeholder="Username">
                </div>

                <label class="sr-only" for="email">Email</label>
                <div class="input-group input-group-sm my-1 mr-sm-2">
                    <div class="input-group-prepend">
                    <div class="input-group-text">@</div>
                    </div>
                    <input type="text" class="form-control form-control-sm" id="email" name="email" placeholder="Email">
                </div>

                <label class="my-1 mr-2" for="status">Status</label>
                <select class="form-control form-control-sm my-1 mr-2" id="status" name="status">
                    <option selected></option>
                    <option value="0">ACTIVE</option>
                    <option value="1">INACTIVE</option>
                </select>
                
                <button type="submit" class="btn btn-primary btn-sm my-2">Apply</button>
                <cfif request.helper.hasPermission( 'createUser' )>
                    <a  class="btn btn-primary btn-sm my-2 ml-2"
                        href="#application.APP_PATH#index.cfm?appmodule=User&appaction=dsp_createUser" 
                        >Create User
                    </a>
                </cfif>

            </form>
            </cfoutput>
        </div>
    </div>

    
    <!--- -------------------- LIST OF USER ------------------- --->
    <cfif isValid("query", attributes.q_user)>
        <div class="card mt-4">
            <div class="card-body">
                
                <cfif attributes.q_user.recordCount eq 0>
                    <cfmodule 
                        template="/template/alertMessage.cfm" 
                        type="secondary"
                        message="No record found"
                        >
                </cfif>
                
                <table class="table table-sm table-bordered table-hover">
                    <thead class="table-secondary">
                        <tr>
                            <th scope="col">Username</th>
                            <th scope="col">Email</th>
                            <th scope="col">Status</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfoutput query="attributes.q_user">
                            <tr>
                                <td>#encodeForHTML( vaUsername )#</td>
                                <td>#encodeForHTML( vaEmail )#</td>
                                <td>
                                    <cfif siStatus eq 0>
                                        <span class="badge bg-success">ACTIVE</span>
                                    <cfelseif siStatus eq 1>
                                        <span class="badge bg-secondary">INACTIVE</span>
                                    <cfelseif siStatus eq 2>
                                        <span class="badge bg-primary">FIRST TIME LOGIN</span>
                                    <cfelseif siStatus eq 3>
                                        <span class="badge bg-warning">LOCKED</span>
                                    </cfif>
                                </td>
                                <td>
                                    <a href="#application.APP_PATH#index.cfm?appmodule=User&appaction=dsp_showUser&userid=#encodeForURL( iUserID )#" 
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