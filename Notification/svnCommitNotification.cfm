<cfparam name="attributes.revisionID" default="">
<cfparam name="attributes.action" default="">


<cfquery name="q_review" >
    SELECT R.iIssueID, R.vaTitle, REV.iRevisionID, REV.vaMessage, REV.vaMessage, REV.vaAuthor,
        reviewStatus = R.vaStatus,
        revisionStatus = REV.vaStatus,
        developerEmail = U2.vaEmail,
        reviewerName = U1.vaUsername,
        developerName = U2.vaUsername
    FROM Review R WITH (NOLOCK)
        INNER JOIN Revision REV ON REV.iReviewID = R.iReviewID
        LEFT JOIN Users U1 ON R.iReviewer = U1.iUserID
        LEFT JOIN Users U2 ON R.iDeveloper = U2.iUserID
    WHERE REV.iRevisionID = <cfqueryparam value="#attributes.revisionID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif attributes.action eq "create">
    <cfset subject = "New Commit Created">
    <cfset title = "Revision <i>#encodeForHTML( q_review.iRevisionID )#</i> has been added.">
</cfif>


<cfmail 
    subject="#subject#"
    to="#q_review.developerEmail#"
    from="no-reply@mmreview.com"
    type="html">

    <h2>#title#</h2>
    <br>
    <br>
    Issue       : ## #encodeForHTML( q_review.iIssueID )#<br>
    Title       : #encodeForHTML( q_review.vaTitle )#<br>
    Developer   : #encodeForHTML( q_review.developerName )#<br>
    Reviewer    : #encodeForHTML( q_review.reviewerName )#<br>
    Status      : #encodeForHTML( q_review.reviewStatus )#<br>

    <br>
    <br>
    Revision        : #encodeForHTML( q_review.iRevisionID )#<br>
    Author          : #encodeForHTML( q_review.vaAuthor )#<br>
    Message         : #encodeForHTML( q_review.vaMessage )#<br>
    Revision Status : #encodeForHTML( q_review.revisionStatus )#<br>

</cfmail>