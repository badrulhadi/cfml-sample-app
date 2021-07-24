<cfparam name="form.status" default="">
<cfparam name="form.username" default="">
<cfparam name="form.email" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">
<cfparam name="q_user" default="">


<!--- validate user input --->

<cfif len(form.status) neq 0 and not arrayFind([1, 0], form.status)>
	<cfset alert.type = "error">
	<cfset alert.message = 'Status can only be "ACTIVE" or "INACTIVE"'>
</cfif>


<!--- query data --->
<cfif len(alert.type) eq 0 >
	<cftry>
		<cfquery name="q_user">
			SELECT iUserID, vaUsername, vaEmail, siStatus
			FROM Users
			WHERE  1=1

			<cfif len(form.username) neq 0>
				AND vaUserName LIKE <cfqueryparam value="%#form.username#%" cfsqltype="cf_sql_nvarchar">
			</cfif>

			<cfif len(form.email) neq 0>
				AND vaEmail LIKE <cfqueryparam value="%#form.email#%" cfsqltype="cf_sql_nvarchar">
			</cfif>

			<cfif len(form.status) neq 0>
				AND siStatus = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">
			</cfif>

			ORDER BY dtCreatedOn DESC
		</cfquery>
		
		<cfcatch type="any">
			<cfdump var="#cfcatch#" abort>
			<cfset alert.type = "error">
			<cfset alert.message = 'An Error occur'>
		</cfcatch>
	</cftry>
</cfif>

<!------------- DISPLAY ------------->
<cfmodule template="dsp_listUser.cfm" q_user="#q_user#" alert="#alert#">