<cfparam name="form.postID" default="0">
<cfparam name="form.comment" default="">

<cfset data = {}>
<cfloop index="item" list="#form.fieldnames#">
    <cfset data[item] = form[item]> 
</cfloop>


<!--- validate user input --->



<!--- Save Data --->
<cfquery name="q_insertComment">
    INSERT INTO Comment (
        ipostID,  vaComment, iCreatedBy
    )
    VALUES (
        <cfqueryparam value="#data.postID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#data.comment#" cfsqltype="cf_sql_nvarchar">,
        <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
    )
</cfquery>


<cflocation 
    url="#application.APP_PATH#index.cfm?appmodule=Post&appaction=dsp_viewPost&postID=#form.postID#" 
    addtoken="false">


<!------------- TRY AGAIN ------------->
<!--- <cfmodule template="dsp_createReview.cfm" alert="#alert#"> --->