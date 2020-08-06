<!--- Check if user session not exist redirect to login --->
<cfif not structKeyExists( session, "user" )>
    <cflocation url="#application.APP_PATH#/index.cfm" >
</cfif>


<!--- ------------ DISPLAY ------------ --->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <title><cfoutput>#application.APP_NAME#</cfoutput></title>

    <link 
        rel="stylesheet" 
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" 
        integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" 
        crossorigin="anonymous">
        
    <link 
        rel="stylesheet" 
        href="../assets/css/starter.css"> 

</head>

<body>
    <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
        <a class="navbar-brand" href="#"><cfoutput>#application.APP_NAME#</cfoutput></a>
        <button class="navbar-toggler" type="button" 
            data-toggle="collapse" 
            data-target="#navbarsExampleDefault" 
            aria-controls="navbarsExampleDefault" 
            aria-expanded="false" 
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <cfoutput>
        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#application.APP_PATH#/home/home.cfm">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="##">Timesheet</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="##" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Security</a>
                    <div class="dropdown-menu" aria-labelledby="dropdown01">
                    <a class="dropdown-item" href="#application.APP_PATH#/userProfile/dsp_listUser.cfm">User Profile</a>
                    <a class="dropdown-item" href="#application.APP_PATH#/auth/dsp_changePassword.cfm">Change Password</a>
                    </div>
                </li>
            </ul>

            <!--- <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
            </form> --->

            <cfif structKeyExists(session, 'user') >
                <form class="form-inline my-2 my-lg-0" action="#application.APP_PATH#/auth/act_logout.cfm" method="POST">
                    <button class="btn btn-secondary my-2 my-sm-0" type="submit" name="logout">Logout</button>
                </form>
            <cfelse>
                <a href="#application.APP_PATH#/auth/dsp_login.cfm" class="btn btn-secondary my-2 my-sm-0">Login</a>
            </cfif>
        </div>
        </cfoutput>
    </nav>

