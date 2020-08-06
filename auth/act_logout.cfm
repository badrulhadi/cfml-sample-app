
<cfset sessionInvalidate()>
<cfset structClear( session )>

<cflocation url="#application.APP_PATH#/index.cfm" addtoken="false">