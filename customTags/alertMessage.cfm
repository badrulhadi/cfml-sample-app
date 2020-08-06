<cfparam name="attributes.type" default="">
<cfparam name="attributes.message" default="">
<cfparam name="session.alertType" default="">
<cfparam name="session.alertMessage" default="">


<cfif len(attributes.message) eq 0 and  len(session.alertMessage) neq 0>
    <cfset attributes.message = session.alertMessage>
</cfif>


<cfoutput>
    <cfif attributes.type eq "success" or session.alertType eq "success">
        <div class="alert alert-success" role="alert">
            #attributes.message#
        </div>

    <cfelseif attributes.type eq "primary" or session.alertType eq "primary">
        <div class="alert alert-primary" role="alert">
            #attributes.message#
        </div>

    <cfelseif attributes.type eq "secondary" or session.alertType eq "secondary">
        <div class="alert alert-secondary" role="alert">
            #attributes.message#
        </div>

    <cfelseif attributes.type eq "error" or session.alertType eq "error">
        <div class="alert alert-danger" role="alert">
            #attributes.message#
        </div>
    </cfif>
</cfoutput>


<cfset structDelete(session, "alertType")>
<cfset structDelete(session, "alertMessage")>