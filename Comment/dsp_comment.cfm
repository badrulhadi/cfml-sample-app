<cfparam name="attributes.postID" default="0">


<!--- ------------- QUERY DATA ------------- --->

<cfquery name="q_comment">
    SELECT C.iPostID, C.iCreatedBy, C.dtCreatedOn, C.vaComment, U.vaUsername
    FROM Comment C WITH (NOLOCK)
        LEFT JOIN Users U ON C.iCreatedBy = U.iUserID  
    WHERE 1=1

    <cfif attributes.postID neq 0>
        AND C.iPostID = <cfqueryparam value="#attributes.postID#" cfsqltype="cf_sql_integer"> 
    </cfif>

    ORDER BY iCommentID
</cfquery>


<!--- -------------- DISPLAY -------------- --->
<div class="card my-4">
    <div class="card-header font-weight-bold">
        <span>Comments</span>
    </div>
    <div class="card-body">
        <cfoutput query="q_comment">
        <div class="media mb-2">
            <img src="https://dummyimage.com/300" class="mr-3" alt="" height="50">
            <div class="media-body">
                <p class="my-0">
                    <b>#encodeForHTML( vaUsername )#</b>
                    <small class="text-muted">on #dateFormat( dtCreatedOn, 'YYYY-MM-dd')#</small>
                </p>
                #encodeForHTML(vaComment)#
            </div>
        </div>
        </cfoutput>
    </div>

    <div class="card-footer bg-white">
        <cfoutput>
        <form
            action="#application.APP_PATH#index.cfm?appmodule=Comment&appaction=act_comment" 
            method="POST">

            <input type="hidden" name="postID" value="#attributes.postID#">
            <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

            <div class="mb-3">
                <label for="comment">Add Comment :</label>
                <textarea class="form-control" id="comment" name="comment" placeholder="" required></textarea>
            </div>

            <div class="form-group row mb-2">
                <div class="col-sm-12">
                    <button type="submit" class="btn btn-primary float-right">Add Comment</button>
                </div>
            </div>
        </form>
        </cfoutput>
    </div>
</div>