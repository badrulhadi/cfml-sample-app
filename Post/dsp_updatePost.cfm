<cfparam name="attributes.postID" default="">
<cfparam name="attributes.alert" default="#structNew()#">

<!--- ------------- QUERY DATA ------------- --->

<cfquery name="q_post">
    SELECT iPostID, vaTitle, vaContent, siStatus, dtCreatedOn
    FROM Post P WITH (NOLOCK)
    WHERE iPostID = <cfqueryparam value="#attributes.postID#" cfsqltype="cf_sql_integer">
</cfquery>


<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">

<main class="flex-shrink-0">

<div class="container">

    <div>
        <h2 class="mt-5">Update Post</h2>
    </div>

    <cfmodule template="/template/alertMessage.cfm" attributecollection="#attributes.alert#">

    <div class="card mt-4">
        <div class="card-body">
            <cfoutput>
            <form 
                action="#application.APP_PATH#index.cfm?appmodule=Post&appaction=act_updatePost" 
                method="POST">

                <input type="hidden" name="postID" value="#q_post.iPostID#">
                <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

                <div class="row mb-3">
                    <label for="title" class="col-sm-2 col-form-label">Title</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="title" name="title" value="#encodeForHTML(q_post.vaTitle)#" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <label for="content" class="col-sm-2 col-form-label">Content</label>
                    <div class="col-sm-8">
						<textarea 
							id="content" 
							name="content" 
							class="form-control" 
							rows="6"
							required
							>#encodeForHTML(q_post.vaContent)#</textarea>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a  href="#application.APP_PATH#index.cfm?appmodule=Home&appaction=dsp_home"
                            class="btn btn-secondary">
                            Cancel
                        </a>
                    </div>
                </div>
            </form>
            </cfoutput>
        </div>
    </div>
</div>

</main>

<cfmodule template="/template/footer.cfm">