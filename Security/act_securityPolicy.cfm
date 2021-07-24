<cfparam name="form.minPasswordLength" default="">
<cfparam name="form.disableLastPassword" default="">
<cfparam name="form.failLoginBeforeLock" default="">
<cfparam name="form.lockOutPeriod" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">


<!--- validate user input --->

<cfif len( form.minPasswordLength ) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Minimum password length cannot be empty">
</cfif>

<cfif len( form.minPasswordLength ) neq 0 
    AND (not isValid('numeric', form.minPasswordLength) OR form.minPasswordLength lt 1)>
	<cfset alert.type = "error">
	<cfset alert.message = "Minimum password length must be a number and must be more that ZERO">
</cfif>


<cfif len(alert.type) eq 0 >

    <cfquery name="q_updateSecurityPolicy">
        UPDATE SecurityPolicy
        SET iValue = <cfqueryparam value="#form.minPasswordLength#" cfsqltype="cf_sql_integer">
            , dtModifiedOn = GETDATE()
            , iModifiedBy = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
        WHERE vaPolicyName = <cfqueryparam value="minPasswordLength" cfsqltype="cf_sql_nvarchar">
    </cfquery>

    <cfquery name="q_updateSecurityPolicy">
        UPDATE SecurityPolicy
        SET iValue = <cfqueryparam value="#form.disableLastPassword#" cfsqltype="cf_sql_integer">
            , dtModifiedOn = GETDATE()
            , iModifiedBy = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
        WHERE vaPolicyName = <cfqueryparam value="disableLastPassword" cfsqltype="cf_sql_nvarchar">
    </cfquery>

    <cfquery name="q_updateSecurityPolicy">
        UPDATE SecurityPolicy
        SET iValue = <cfqueryparam value="#form.failLoginBeforeLock#" cfsqltype="cf_sql_integer">
            , dtModifiedOn = GETDATE()
            , iModifiedBy = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
        WHERE vaPolicyName = <cfqueryparam value="failLoginBeforeLock" cfsqltype="cf_sql_nvarchar">
    </cfquery>

    <cfquery name="q_updateSecurityPolicy">
        UPDATE SecurityPolicy
        SET iValue = <cfqueryparam value="#form.lockOutPeriod#" cfsqltype="cf_sql_integer">
            , dtModifiedOn = GETDATE()
            , iModifiedBy = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
        WHERE vaPolicyName = <cfqueryparam value="lockOutPeriod" cfsqltype="cf_sql_nvarchar">
    </cfquery>

    <cfset alert.type = "success">
    <cfset alert.message = "Security Policy updated">

</cfif>

<cfset session.vars.alertType = alert.type>
<cfset session.vars.alertMessage = alert.message>

<cflocation url="#application.APP_PATH#index.cfm?appmodule=Security&appaction=dsp_securityPolicy" addtoken="false">