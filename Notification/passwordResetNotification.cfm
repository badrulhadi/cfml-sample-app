<cfparam name="attributes.userID" default="">
<cfparam name="attributes.tempPassword" default="">

<cfquery name="q_user">
    SELECT vaUsername, vaEmail FROM Users WITH (NOLOCK)
    WHERE iUserID = <cfqueryparam value="#attributes.userID#" cfsqltype="cf_sql_integer">
</cfquery>


<cfset subject = "#application.APP_NAME# - Password Reset ">
<cfset title = "Your password has been reset by administrator">


<cfmail 
    subject="#subject#"
    to="#q_user.vaEmail#"
    from="no-reply@mmreview.com"
    type="html">

    <h2>#title#</h2>
    <br>
    <br>
    Username            : #q_user.vaUsername#<br>
    Temporary Password  : #attributes.tempPassword#<br>
    <br>
    <br>
    Please login here to and change your password :<br>
    <a href="#application.APP_URL#">#application.APP_URL#</a>
</cfmail>