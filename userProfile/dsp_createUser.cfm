<cfmodule template="#application.APP_PATH#/customTags/header.cfm">

<!--- ------------- DISPLAY ------------- --->

<div class="container">

    <div>
        <h2>Create New User</h2>
    </div>

    <cfmodule template="#application.APP_PATH#/customTags/alertMessage.cfm">

    <div class="card mt-4">
        <div class="card-body">
            <cfoutput>
            <form 
                action="#application.APP_PATH#/userProfile/act_createUser.cfm" 
                method="POST">

                <div class="form-group row">
                    <label for="username" class="col-sm-2 col-form-label">Username</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="username" name="username" autocomplete="off" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="email" class="col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-6">
                        <input type="email" class="form-control" id="email" name="email" autocomplete="off" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="role" class="col-sm-2 col-form-label">Role</label>
                    <div class="col-sm-6">
                        <select class="form-control" id="role" name="role" required>
                            <option selected disabled></option>
                            <option value="Administrator">Administrator</option>
                            <option value="User">User</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Create</button>
                        <a href="#application.APP_PATH#/userProfile/dsp_listUser.cfm" class="btn btn-secondary">Cancel</a>
                    </div>
                </div>
            </form>
            </cfoutput>
        </div>
    </div>
</div>

<cfmodule template="#application.APP_PATH#/customTags/footer.cfm">