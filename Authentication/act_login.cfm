<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">


<!--- validate user input --->

<cfif len(form.username) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Username cannot be empty">
</cfif>

<cfif len(form.password) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Password cannot be empty">
</cfif>

<!--- <cfdump var="#attributes#"> --->


<cfif len(alert.type) eq 0 >
    <cfquery name="q_user">
        SELECT iUserID, vaUsername, vaPassword, vaSalt, iLoginFailedCount, dtLockedExpiredOn, siStatus
        FROM Users
        WHERE vaUsername = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_nvarchar">
    </cfquery>

    <cfset inactive = 1>
    <cfset isLocked = 3>
    
    <cfif q_user.recordCount neq 1 OR q_user.siStatus eq inactive>
        <cfset alert.type = "error">
        <cfset alert.message = "Invalid UserID or Password. Please try again.">
    <cfelseif q_user.siStatus eq isLocked AND dateCompare(q_user.dtLockedExpiredOn, now()) eq 1 >
        <cfset alert.type = "error">
        <cfset alert.message = "User ID currently locked due to many fail login attempt. Please try again later.">
    </cfif>
</cfif>


<cfif len(alert.type) eq 0 >
    <cfset loginSuccess = false>

    <cfset security = new component.Security()> 
    <cfset loginSuccess = security.verifyPassword( form.password, q_user.vaPassword, q_user.vaSalt )> 

    <cfif loginSuccess >
        <cfset firstTimeLogin = 2>
        <cfif q_user.siStatus eq firstTimeLogin>
            <cfmodule 
                template="#application.APP_PATH#index.cfm"
                appmodule="Authentication"
                appaction="act_setSessionVars"
                firstTimeLogin="true"
                userID="#q_user.iUserID#">

            <cfmodule 
                template="#application.APP_PATH#index.cfm"
                appmodule="Authentication"
                appaction="dsp_changePassword"
                firstTimeLogin="true"
                userID="#q_user.iUserID#">
            
            <cfabort>
        </cfif>

        <cfdump var="#attributes#">
        <cfmodule 
            template="#application.APP_PATH#index.cfm"
            appmodule="Authentication"
            appaction="act_setSessionVars"
            userID="#q_user.iUserID#">

        <cfquery name="q_updateUser">
            UPDATE Users 
            SET iLoginFailedCount = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
                , dtLastLogin = GETDATE()
                , siStatus = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
            WHERE iUserID = <cfqueryparam value="#q_user.iUserID#" cfsqltype="cf_sql_integer">
        </cfquery>
    
        <cflocation url="#application.APP_PATH#index.cfm?appmodule=Home&appaction=dsp_home" addtoken="true">
        <!--- <cfmodule 
            template="#application.APP_PATH#index.cfm"
            appmodule="Home"
            appaction="dsp_home"> --->
    
    <cfelse>
        <cfset alert.type = "error">
        <cfset alert.message = "Invalid UserID or Password. Please try again.">
    
        <cfset status = 0>
        <cfset lockExpiredDate = "">
        <cfset failedLoginCount = len(q_user.iLoginFailedCount) eq 0? 1 : q_user.iLoginFailedCount + 1>
        <cfset failLoginCountPolicy = security.getSecurityPolicy('failLoginBeforeLock')>
        <cfset lockOutPeriod = security.getSecurityPolicy('lockOutPeriod')>

        <cfif failedLoginCount gte failLoginCountPolicy>
            <cfset status = 3>
            <cfset lockExpiredDate = dateAdd('n', lockOutPeriod, now())>
            <cfset alert.message = "User ID has been locked due to many fail login attempt. Please try again later">
        </cfif>
    
        <cfquery name="q_updateUser">
            UPDATE Users 
            SET iLoginFailedCount = <cfqueryparam value="#failedLoginCount#" cfsqltype="cf_sql_integer">
                <cfif len(lockExpiredDate) neq 0>
                , dtLockedExpiredOn = <cfqueryparam value="#lockExpiredDate#" cfsqltype="cf_sql_timestamp">
                </cfif>
                , dtLastFailedLogin = GETDATE()
                , siStatus = <cfqueryparam value="#status#" cfsqltype="cf_sql_integer">
            WHERE iUserID = <cfqueryparam value="#q_user.iUserID#" cfsqltype="cf_sql_integer">
        </cfquery>
    
    </cfif>
</cfif>

<!--- <cfdump var="#alert#"> --->
<!--- No user found / wrong password or username --->

<cfmodule 
	template="#application.APP_PATH#index.cfm"
	appmodule="Authentication"
	appaction="login"
	alert="#alert#">
