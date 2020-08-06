
<cfapplication 
    name="CFML-Sample-APP"
    setClientCookies="true" 
    sessionmanagement="true"
    sessiontimeout="#CreateTimeSpan(0, 1, 0, 0)#"  <!--- 30 minutes  --->
    >


<!--- Initialize local app_is_initialized flag to false. --->
<cfset app_is_initialized = false>

<!--- Uncomment to reload application scope --->
<!--- <cfset structDelete(application, "initialized")> --->


<cflock scope="application" type="readonly" timeout=10>
    <!--- Read init flag and store it in local variable. --->
    <cfset app_is_initialized = IsDefined("application.initialized")>
</cflock>


<!--- Check the local flag. --->
<cfif not app_is_initialized>
    <!--- 
        application variables are not initialized yet.
        Get an exclusive lock to write scope. 
    --->
    <cflock scope="application" type="exclusive" timeout=10>
        <!--- 
            Check the application scope initialized flag since another request
            could have set the variables after this page released the read-only
            lock. 
        --->
        <cfif not IsDefined("application.initialized")>
            <!--- Do initializations --->
            <cfset application.APP_NAME = "sampleApp">
            <cfset application.APP_PATH = "/sampleApp">
            <cfset application.APP_DSN = "miniProject">
            
            <!--- Set the application scope initialization flag. --->
            <cfset application.initialized = true>
        </cfif>
    </cflock>
</cfif>
