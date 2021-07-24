<cfparam name="attributes.postID" default="">
<cfparam name="attributes.alert" default="#structNew()#">

<!--- ------------- QUERY DATA ------------- --->

<cfquery name="q_post">
    SELECT
        P.iPostID, P.vaTitle, P.vaContent, P.siStatus, P.dtCreatedOn,
        authorID = U.iUserID,
        author = U.vaUsername
    FROM Post P WITH (NOLOCK)
       LEFT JOIN Users U ON P.iCreatedBy = U.iUserID 
    WHERE P.iPostID = <cfqueryparam value="#attributes.postID#" cfsqltype="cf_sql_integer">
</cfquery>


<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h4 class="mt-5"><cfoutput>#encodeForHTML(q_post.vaTitle)#</cfoutput></h4>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <div class="card mt-4">
        <div class="card-header font-weight-bold">
            <cfoutput>
                by <span class="fst-italic">#encodeForHTML(q_post.author)#</span>
                on <span class="fst-italic">#dateFormat(q_post.dtCreatedOn)#</span>

                <a  href="#application.APP_PATH#index.cfm?appmodule=Post&appaction=dsp_updatePost&postID=#q_post.iPostID#" 
                    class=" float-end btn btn-primary btn-sm">
                    Edit
                </a>
            </cfoutput>
        </div>
        <div class="card-body">
            <cfoutput>
                #encodeForHTML(q_post.vaContent)#
            </cfoutput>
        </div>
    </div>

    <!---------------------------- COMMENTS ---------------------------->
    <cfmodule 
        template="#application.APP_PATH#/index.cfm" 
        appmodule="Comment" 
        appaction="dsp_comment" 
        postID="#q_post.iPostID#">
</div>

</main>

<cfmodule template="/template/footer.cfm">