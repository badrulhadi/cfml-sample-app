<cfparam name="attributes.alert" default="#structNew()#">
<cfparam name="attributes.userID" default="">

<!--- ------------- QUERY DATA ------------- --->

<cfquery name="q_getSecurityPolicy">
	SELECT vaPolicyName, iValue
	FROM SecurityPolicy WITH (NOLOCK)
</cfquery>

<cfset policy = {}>
<cfloop query="q_getSecurityPolicy">
	<cfset policy[vaPolicyName] = iValue>
</cfloop>

<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">
    
	<div>
		<h2 class="mt-5">Security Policy</h2>
	</div>

	<cfmodule 
		template="/template/alertMessage.cfm"
		attributecollection="#attributes.alert#">

	<div class="card mt-4">
		<div class="card-body">
			<cfoutput>
			<form 
				action="#application.APP_PATH#index.cfm?fusebox=Sec&fuseaction=act_securityPolicy" 
				method="POST">

				<input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

				<div class="row mb-3">
					<label for="minPasswordLength" class="col-sm-4 col-form-label">Minimum password length</label>
					<div class="col-sm-1">
						<input 
							type="number" 
							class="form-control" 
							id="minPasswordLength" 
							name="minPasswordLength" 
							value="#policy.minPasswordLength#"
							autocomplete="off" required>
					</div>
				</div>

				<div class="row mb-3">
					<label for="disableLastPassword" class="col-sm-4 col-form-label">Number of last password disabled</label>
					<div class="col-sm-1">
						<input 
							type="number" 
							class="form-control" 
							id="disableLastPassword" 
							name="disableLastPassword" 
							value="#policy.disableLastPassword#"
							autocomplete="off" required>
					</div>
				</div>

				<div class="row mb-3">
					<label for="failLoginBeforeLock" class="col-sm-4 col-form-label">No of login failures before lock out  </label>
					<div class="col-sm-1">
						<input 
							type="number" 
							class="form-control" 
							id="failLoginBeforeLock" 
							name="failLoginBeforeLock" 
							value="#policy.failLoginBeforeLock#"
							autocomplete="off" required>
					</div>
				</div>

				<div class="row mb-3">
					<label for="lockOutPeriod" class="col-sm-4 col-form-label">Locked out period in minutes </label>
					<div class="col-sm-1">
						<input 
							type="number" 
							class="form-control" 
							id="lockOutPeriod" 
							name="lockOutPeriod" 
							value="#policy.lockOutPeriod#"
							autocomplete="off" required>
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-4"></div>
					<div class="col-sm-2">
						<button type="submit" class="btn btn-primary">Update</button>
					</div>
				</div>
			</form>
			</cfoutput>
		</div>
	</div>
</div>

</main>

<cfmodule template="/template/footer.cfm">
