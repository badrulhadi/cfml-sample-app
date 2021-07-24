<cfparam name="attributes.type" default="">
<cfparam name="attributes.message" default="">
<cfparam name="attributes.clearSession" default="false"><!--- true: clear seesion --->
<cfparam name="session.vars.alertType" default="">
<cfparam name="session.vars.alertMessage" default="">


<cfif len(attributes.message) eq 0 and  len(session.vars.alertMessage) neq 0>
    <cfset attributes.message = session.vars.alertMessage>
</cfif>


<cfoutput>
<cfif attributes.type eq "success" or session.vars.alertType eq "success">
    <div class="alert alert-success" role="alert">
        #attributes.message#
    </div>

<cfelseif attributes.type eq "primary" or session.vars.alertType eq "primary">
    <div class="alert alert-primary" role="alert">
        #attributes.message#
    </div>

<cfelseif attributes.type eq "secondary" or session.vars.alertType eq "secondary">
    <div class="alert alert-secondary" role="alert">
        #attributes.message#
    </div>

<cfelseif attributes.type eq "error" or session.vars.alertType eq "error">
    <div class="alert alert-danger" role="alert">
        #attributes.message#
    </div>
</cfif>
</cfoutput>

<!--- <cfdump var="#attributes#" abort> --->
<cfset structDelete(session.vars, "alertType")>
<cfset structDelete(session.vars, "alertMessage")>

<cfif attributes.clearSession>
    <!--- <cfset structDelete(session, "vars")> --->
    <cfset sessionInvalidate()>
    <cfset structClear( session )>
</cfif>