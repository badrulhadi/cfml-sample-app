
<cfif ( not structKeyExists(session, "user") )>
    <cflocation url="auth/dsp_login.cfm" addtoken="false">
</cfif>

<cflocation url="home/home.cfm" addtoken="false">

