<cfparam name="form.title" default="">
<cfparam name="form.content" default="">
<cfparam name="alert.type" default="">
<cfparam name="alert.message" default="">


<!--- validate user input --->

<cfif len(form.title) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Title cannot be empty">
</cfif>

<cfif len(form.content) eq 0>
	<cfset alert.type = "error">
	<cfset alert.message = "Content cannot be empty">
</cfif>


<!--- Save Data --->
<cfif len(alert.type) eq 0 >
    <cfquery name="q_insertPost" result="newPost">
        INSERT INTO Post (
            vaTitle, vaContent, iCreatedBy
        )
        VALUES (
            <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.content#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
        )
    </cfquery>
</cfif>


<cfif len(alert.type) eq 0 >
    <!--- <cfset session.vars.alertType = "success">
    <cfset session.vars.alertMessage = "Succesfully created new Post"> --->

    <cflocation 
        url="#application.APP_PATH#index.cfm?appmodule=Post&appaction=dsp_viewPost&postID=#newPost.generatedKey#" 
        addtoken="false">
</cfif>

<!------------- TRY AGAIN ------------->
<cfmodule template="dsp_newPost.cfm" alert="#alert#">