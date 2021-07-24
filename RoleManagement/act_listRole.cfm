<cfparam name="form.status" default="">
<cfparam name="form.roleName" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">
<cfparam name="q_role" default="">


<!--- validate user input --->

<cfif len(form.status) neq 0 and not arrayFind([1, 0], form.status)>
	<cfset alert.type = "error">
	<cfset alert.message = 'Status can only be "ACTIVE" or "INACTIVE"'>
</cfif>


<!--- query data --->
<cfif len(alert.type) eq 0 >
	<cftry>
		<cfquery name="q_role">
			SELECT iRoleID, vaRoleName, siStatus
			FROM Roles
			WHERE  1=1

			<cfif len(form.roleName) neq 0>
				AND vaRoleName LIKE <cfqueryparam value="%#form.roleName#%" cfsqltype="cf_sql_nvarchar">
			</cfif>

			<cfif len(form.status) neq 0>
				AND siStatus = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">
			</cfif>

			ORDER BY dtCreatedOn DESC
		</cfquery>
		
		<cfcatch type="any">
			<cfset alert.type = "error">
			<cfset alert.message = 'An Error occur'>
		</cfcatch>
	</cftry>
</cfif>

<!------------- DISPLAY ------------->
<cfmodule template="dsp_listRole.cfm" q_role="#q_role#" alert="#alert#">