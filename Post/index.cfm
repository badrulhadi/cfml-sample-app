<cfparam name="attributes.appaction" default="">

<!--- <cfdump var="#session#" abort> --->
<cfif NOT structKeyExists( session, 'vars')>
	<cfthrow TYPE="EX_SECFAILED" ErrorCode="NOLOGIN">
</cfif>


<cfswitch expression=#attributes.appaction#>
	<cfcase value="dsp_newPost">
		<cfif not request.helper.hasPermission( 'createPost' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="dsp_newPost.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_newPost">
		<cfif not request.helper.hasPermission( 'createPost' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="act_newPost.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="dsp_viewPost">
		<cfif not request.helper.hasPermission( 'viewPost' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="dsp_viewPost.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="dsp_updatePost">
		<cfif not request.helper.hasPermission( 'updatePost' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="dsp_updatePost.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfcase value="act_updatePost">
		<cfif not request.helper.hasPermission( 'updatePost' ) >
			<cfthrow type="EX_SECFAILED" errorCode="ACCESSDENIED" >
		</cfif>

		<cfmodule template="act_updatePost.cfm" attributecollection=#Attributes#>
	</cfcase>

	<cfdefaultcase>
		<cfthrow TYPE="EX_SECFAILED" ErrorCode="NODIRECT">
	</cfdefaultcase>
</cfswitch>
