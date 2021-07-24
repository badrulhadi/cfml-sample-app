<cfparam name="form.username" default="">
<cfparam name="form.email" default="">
<cfparam name="form.role" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">


<!--- validate user input --->

<cfif len(form.email) neq 0 and not isValid("email", form.email)>
	<cfset alert.type = "error">
	<cfset alert.message = "Please input valid email">
</cfif>

<cfif len(form.email) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Email cannot be empty">
</cfif>

<cfif len(form.username) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Username cannot be empty">
</cfif>

<cfif len(form.role) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Role cannot be empty">
</cfif>


<cfif len(alert.type) eq 0 >
    <cfquery name="q_checkUsernameExist">
        SELECT vaUsername
        FROM Users WITH (NOLOCK)
        WHERE vaUsername = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_nvarchar">
    </cfquery>

    <cfif q_checkUsernameExist.recordCount gt 0>
        <cfset alert.type = "error">
        <cfset alert.message = "That username already taken">
    </cfif>
</cfif>

<cfif len(alert.type) eq 0 >
    <cfquery name="q_checkEmailExist">
        SELECT vaEmail
        FROM Users WITH (NOLOCK)
        WHERE vaEmail = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_nvarchar">
    </cfquery>

    <cfif q_checkEmailExist.recordCount gt 0>
        <cfset alert.type = "error">
        <cfset alert.message = "Email already registered with the system. Please use different email.">
    </cfif>
</cfif>



<!--- Save Data --->
<cfif len(alert.type) eq 0 >

    <cfset security = new component.Security()> 
    <cfset tempPassword = security.generatePassword( 10 ) >
    <cfset salt = security.generateSalt() >
    <cfset hashTempPassword = security.hashPassword( tempPassword, salt )>

    <cfset firstTimeLogin = 2>
    <cfset userRoles = listToArray(form.role)>

    <cftransaction>
        <cftry>
            <cfquery name="q_createUser" result="qResult">
                INSERT INTO Users (
                    vaUsername, vaEmail, vaPassword, vaSalt, iCreatedBy, siStatus
                )
                VALUES (
                    <cfqueryparam value="#form.username#" cfsqltype="cf_sql_nvarchar">,
                    <cfqueryparam value="#form.email#" cfsqltype="cf_sql_nvarchar">,
                    <cfqueryparam value="#hashTempPassword#" cfsqltype="cf_sql_nvarchar">,
                    <cfqueryparam value="#salt#" cfsqltype="cf_sql_nvarchar">,
                    <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#firstTimeLogin#" cfsqltype="cf_sql_integer">
                )
            </cfquery>

            <cfquery name="q_insertUserRole">
                INSERT INTO UserRole (
                    iUserID, iRoleID, iCreatedBy
                )
                VALUES 
                <cfloop  index="i" from="1" to="#arrayLen(userRoles)#">
                (
                    <cfqueryparam value="#qResult.generatedKey#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#userRoles[i]#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
                )
                <cfif i lt arrayLen( userRoles )> , </cfif>
                </cfloop>
            </cfquery>

            <cfcatch type="any">
                <cftransaction action="rollback" />
                <cfset alert.type = "error">
                <cfset alert.message = "An error occur.">
            </cfcatch>
        </cftry>
        
    </cftransaction>

</cfif>


<cfif len(alert.type) eq 0 >
    <cfset session.vars.alertType = "success">
    <cfset session.vars.alertMessage = "User created succesfully">
    
    <cfmodule 
        template="#application.APP_PATH#Notification/userCreatedNotification.cfm" 
        username="#form.username#"
        email="#form.email#"
        role="#form.role#"
        tempPassword="#tempPassword#">

    <cflocation 
        url="#application.APP_PATH#index.cfm?appmodule=User&appaction=act_listUser" 
        addtoken="false">
</cfif>

<!------------- TRY AGAIN ------------->
<cfmodule template="dsp_createUser.cfm" alert="#alert#">
