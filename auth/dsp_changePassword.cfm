<cfmodule template="#application.APP_PATH#/customTags/header.cfm">

    <!--- ------------- DISPLAY ------------- --->
    
    <div class="container">
    
        <div>
            <h2>Change Password</h2>
        </div>
    
        <cfmodule template="#application.APP_PATH#/customTags/alertMessage.cfm">
    
        <div class="card mt-4">
            <div class="card-body">
                <cfoutput>
                <form 
                    action="#application.APP_PATH#/userProfile/act_changePassword.cfm" 
                    method="POST">
    
                    <div class="form-group row">
                        <label for="currentPassword" class="col-sm-2 col-form-label">Current Password</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" autocomplete="off" required>
                        </div>
                    </div>
    
                    <div class="form-group row">
                        <label for="newPassword" class="col-sm-2 col-form-label">New Password</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="newPassword" name="newPassword" autocomplete="off" required>
                        </div>
                    </div>
    
                    <div class="form-group row">
                        <label for="newPasswordconfirm" class="col-sm-2 col-form-label">Confirm New Password</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="newPasswordconfirm" name="newPasswordconfirm" autocomplete="off" required>
                        </div>
                    </div>
    
                    <div class="form-group row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-10">
                            <button type="submit" class="btn btn-primary">Change</button>
                            <a href="#application.APP_PATH#/home/home.cfm" class="btn btn-secondary">Cancel</a>
                        </div>
                    </div>
                </form>
                </cfoutput>
            </div>
        </div>
    </div>
    
    <cfmodule template="#application.APP_PATH#/customTags/footer.cfm">