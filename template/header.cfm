<!doctype html>
<html lang="en" class="h-100">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="badrul">
		<meta name="generator" content="Hugo 0.84.0">
		<title><cfoutput>#application.APP_NAME#</cfoutput></title>
		

		<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sticky-footer-navbar/">

		<!-- Bootstrap core CSS -->
		<link 
			href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
			rel="stylesheet" 
			integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
			crossorigin="anonymous">

		<style>
			.bd-placeholder-img {
				font-size: 1.125rem;
				text-anchor: middle;
				-webkit-user-select: none;
				-moz-user-select: none;
				user-select: none;
			}

			@media (min-width: 768px) {
				.bd-placeholder-img-lg {
					font-size: 3.5rem;
				}
			}
		</style>

		<!-- Custom styles for this template -->
		<cfoutput>
			<link href="#application.APP_PATH#assets/css/main.css" rel="stylesheet">
		</cfoutput>
	</head>
	<body class="d-flex flex-column h-100">

		<header>
			<!-- Fixed navbar -->
			<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
				<div class="container-fluid">
					<cfoutput>
					<a class="navbar-brand" href="##">#application.APP_NAME#</a>
					</cfoutput>

					<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					
					<div class="collapse navbar-collapse" id="navbarCollapse">
						<ul class="navbar-nav me-auto mb-2 mb-md-0">
						<cfoutput>
							<li class="nav-item">
								<a class="nav-link"
									href="#application.APP_PATH#index.cfm?appmodule=Home&appaction=dsp_home">
									Home
								</a>
							</li>
							<cfif request.helper.hasPermission( 'createPost' )>
								<li class="nav-item">	
									<a class="nav-link"
										href="#application.APP_PATH#index.cfm?appmodule=Post&appaction=dsp_newPost">
										New Post
									</a>
								</li>
							</cfif>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="##" id="dropdown-security" role="button" data-bs-toggle="dropdown" aria-expanded="false">
									Security
								</a>
								<div class="dropdown-menu" aria-labelledby="dropdown-security">
									<a class="dropdown-item" 
										href="#application.APP_PATH#index.cfm?appmodule=User&appaction=dsp_userProfile">
										User Profile
									</a>

									<a class="dropdown-item" 
										href="#application.APP_PATH#index.cfm?appmodule=Authentication&appaction=dsp_changePassword">
										Change Password
									</a>

									<cfif request.helper.hasPermission( 'viewUser' )>
										<a class="dropdown-item" 
											href="#application.APP_PATH#index.cfm?appmodule=User&appaction=act_listUser">
											User Management
										</a>
									</cfif>

									<cfif request.helper.hasPermission( 'manageRole' )>
										<a class="dropdown-item" 
											href="#application.APP_PATH#index.cfm?appmodule=Role&appaction=act_listRole">
											Role Management
										</a>
									</cfif>

									<cfif request.helper.hasPermission( 'manageSecurityPolicy' )>
										<a class="dropdown-item" 
											href="#application.APP_PATH#index.cfm?appmodule=Security&appaction=dsp_securityPolicy">
											Security Policy
										</a>
									</cfif>
								</div>
							</li>
							<!---
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="##" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
									Dropdown
								</a>
								<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
									<li><a class="dropdown-item" href="##">Action</a></li>
									<li><a class="dropdown-item" href="##">Another action</a></li>
									<li><hr class="dropdown-divider"></li>
									<li><a class="dropdown-item" href="##">Something else here</a></li>
								</ul>
							</li>
							--->
						</cfoutput>
						</ul>
						<cfoutput>
							<a  href="#application.APP_PATH#index.cfm?appmodule=Authentication&appaction=logout" 
								class="btn btn-secondary my-2 my-sm-0">Logout</a>
						</cfoutput>
					</div>
				</div>
			</nav>
		</header>
