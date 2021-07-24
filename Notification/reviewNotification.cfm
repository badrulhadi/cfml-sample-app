<cfparam name="attributes.reviewID" default="">
<cfparam name="attributes.action" default="">


<cfquery name="q_review">
    SELECT R.iIssueID, R.vaTitle, R.vaStatus,
        reviewerEmail = U1.vaEmail,
        developerEmail = U2.vaEmail,
        reviewerName = U1.vaUsername,
        developerName = U2.vaUsername
    FROM Review R WITH (NOLOCK)
        LEFT JOIN Users U1 ON R.iReviewer = U1.iUserID
        LEFT JOIN Users U2 ON R.iDeveloper = U2.iUserID
    WHERE R.iReviewID = <cfqueryparam value="#attributes.reviewID#" cfsqltype="cf_sql_integer">
</cfquery>


<cfif attributes.action eq "create">
    <cfset subject = "New Review Created">
    <cfset title = "Review <i>#encodeForHTML( q_review.vaTitle )#</i> has been created.">
<cfelseif attributes.action eq "update">
    <cfset subject = "Review Updated">
    <cfset title = "Review <i>#encodeForHTML( q_review.vaTitle )#</i> has been updated.">
</cfif>


<cfmail 
    subject="#subject#"
    to="#q_review.developerEmail#,#q_review.reviewerEmail#"
    from="no-reply@mmreview.com"
    type="html">

    <h2>#title#</h2>
    <br>
    <br>
    Issue       : ## #encodeForHTML( q_review.iIssueID )#<br>
    Title       : #encodeForHTML( q_review.vaTitle )#<br>
    Developer   : #encodeForHTML( q_review.developerName )#<br>
    Reviewer    : #encodeForHTML( q_review.reviewerName )#<br>
    Status      : #encodeForHTML( q_review.vaStatus )#<br>

</cfmail>