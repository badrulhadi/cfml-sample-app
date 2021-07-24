<!--- ------------ QUERY ------------ --->
<cfquery name="q_personalPost">
	SELECT TOP(20) 
		iPostID, vaTitle, P.siStatus, P.dtCreatedOn
	FROM Post P WITH (NOLOCK)
	WHERE P.siStatus != <cfqueryparam value="1" cfsqltype="cf_sql_integer">
		AND P.iCreatedBy = <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
	ORDER BY P.dtCreatedOn DESC
</cfquery>

<cfquery name="q_peoplePost">
	SELECT TOP(20) 
		iPostID, vaTitle, P.siStatus, P.dtCreatedOn, 
		author = U.vaUsername
	FROM Post P WITH (NOLOCK)
		LEFT JOIN Users U ON P.iCreatedBy = U.iUserID 
	WHERE P.siStatus != <cfqueryparam value="1" cfsqltype="cf_sql_integer">
		AND P.iCreatedBy != <cfqueryparam value="#session.vars.userID#" cfsqltype="cf_sql_integer">
	ORDER BY P.dtCreatedOn DESC
</cfquery>

<!--- ------------- DISPLAY ------------- --->
<cfmodule template="/template/header.cfm">


<main class="flex-shrink-0">
	<div class="container">
		<h1 class="mt-5">Welcome</h1>

		<div class="card mt-5">
			<div class="card-header">
			  <h5>My Post</h5>
			</div>
			<div class="card-body">
				<table class="table table-sm table-bordered table-hover">
					<thead class="table-primary">
					<tr>
						<th scope="col">#</th>
						<th scope="col">Title</th>
						<th scope="col">Date</th>
						<th scope="col">Action</th>
					</tr>
					</thead>
					<tbody>
						<cfset rowNum = 1>
						<cfoutput query="q_personalPost">
						<tr>
							<th scope="row">#rowNum++#</th>
							<td>#vaTitle#</td>
							<td>#dateFormat( dtCreatedOn, 'YYYY-MM-dd' )#</td>
							<td>
								<a href="#application.APP_PATH#index.cfm?appmodule=Post&appaction=dsp_viewPost&postid=#iPostID#" 
									class="btn btn-primary btn-sm" 
									role="button" 
									aria-pressed="true">
									View
								</a>
							</td>
						</tr>
						</cfoutput>
					</tbody>
				</table>
			</div>
		</div>

		<div class="card mt-5">
			<div class="card-header">
			  <h5>Other Post</h5>
			</div>
			<div class="card-body">
				<table class="table table-sm table-bordered table-hover">
					<thead class="table-primary">
					<tr>
						<th scope="col">#</th>
						<th scope="col">Title</th>
						<th scope="col">Author</th>
						<th scope="col">Date</th>
						<th scope="col">Action</th>
					</tr>
					</thead>
					<tbody>
						<cfset rowNum = 1>
						<cfoutput query="q_peoplePost">
						<tr>
							<th scope="row">#rowNum++#</th>
							<td>#vaTitle#</td>
							<td>#author#</td>
							<td>#dateFormat( dtCreatedOn, 'YYYY-MM-dd' )#</td>
							<td>
								<a href="#application.APP_PATH#index.cfm?appmodule=Post&appaction=dsp_viewPost&postid=#iPostID#" 
									class="btn btn-primary btn-sm" 
									role="button" 
									aria-pressed="true">
									View
								</a>
							</td>
						</tr>
						</cfoutput>
					</tbody>
				</table>
			</div>
		</div>
		
	</div>

</main>

<cfmodule template="/template/footer.cfm">