<cfparam name="attributes.action" default="">
<cfparam name="attributes.username" default="">
<cfparam name="attributes.email" default="">
<cfparam name="attributes.role" default="">
<cfparam name="attributes.tempPassword" default="">



<cfset subject = "Welcome to #application.APP_NAME#">
<cfset title = "Your User Account has been created">



<cfmail 
    subject="#subject#"
    to="#attributes.email#"
    from="no-reply@mmreview.com"
    type="html">

    <h2>#title#</h2>
    <br>
    <br>
    Username            : #attributes.username#<br>
    Temporary Password  : #attributes.tempPassword#<br>
    <br>
    <br>
    Please login here to activate your account :<br>
    <a href="#application.APP_URL#">#application.APP_URL#</a>
</cfmail>