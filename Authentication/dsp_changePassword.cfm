<cfparam name="attributes.alert" default="#structNew()#">
<cfparam name="attributes.userID" default="">

<cfset passwordLength = new component.Security().getSecurityPolicy('minPasswordLength')>

<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

	<div>
		<h2 class="mt-5">Change Password</h2>
	</div>

	<cfmodule 
		template="/template/alertMessage.cfm"
		attributecollection="#attributes.alert#">

	<div class="card mt-4">
		<div class="card-body">
			<cfoutput>
			<form 
				action="#application.APP_PATH#index.cfm?appmodule=Authentication&appaction=act_changePassword" 
				method="POST">

				<input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

				<div class="row mb-3">
					<label for="currentPassword" class="col-sm-2 col-form-label">Current Password</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="currentPassword" name="currentPassword" autocomplete="off" required>
					</div>
				</div>

				<div class="row mb-3">
					<label for="newPassword" class="col-sm-2 col-form-label">New Password</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="newPassword" name="newPassword" minlength="#passwordLength#" autocomplete="off" required>
					</div>
				</div>

				<div class="row mb-3">
					<label for="newPasswordConfirm" class="col-sm-2 col-form-label">Confirm New Password</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="newPasswordConfirm" name="newPasswordConfirm" minlength="#passwordLength#" autocomplete="off" required>
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-2"></div>
					<div class="col-sm-10">
						<button type="submit" class="btn btn-primary">Change</button>
						<!--- <a href="#application.APP_PATH#home/home.cfm" class="btn btn-secondary">Cancel</a> --->
					</div>
				</div>
			</form>
			</cfoutput>
		</div>
	</div>
</div>
</main>

<cfmodule template="/template/footer.cfm">
