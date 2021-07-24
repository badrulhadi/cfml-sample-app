<cfparam name="attributes.alert" default="#structNew()#">

<!--- <cfdump var="#attributes#" abort> --->

<!--- ------------- DISPLAY ------------- --->
<cfmodule template="#application.APP_PATH#template/publicHeader.cfm">

  <main class="form-signin">
    <cfoutput>
    <form
      id="login-form" 
      class="form" 
      action="#application.APP_PATH#index.cfm?appmodule=Authentication&appaction=authenticate"
      method="post">

      <input type="hidden" name="formToken" value="#csrfGenerateToken( forceNew = true )#">

      <!--- <img class="mb-4" src="../assets/brand/bootstrap-logo.svg" alt="" width="72" height="57"> --->
      <h1 class="h3 mb-3 fw-normal">Please sign in</h1>

      <cfmodule 
        template="#application.APP_PATH#template/alertMessage.cfm" 
        attributecollection="#attributes.alert#"
        clearSession="true">

      <div class="form-floating">
        <input type="text" name="username" class="form-control" id="floatingInput" placeholder="Username">
        <label for="floatingInput">Username</label>
      </div>
      <div class="form-floating">
        <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password">
        <label for="floatingPassword">Password</label>
      </div>

      <!--- <div class="checkbox mb-3">
        <label>
          <input type="checkbox" value="remember-me"> Remember me
        </label>
      </div> --->
      <button class="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>
      <p class="mt-5 mb-3 text-muted">&copy; 2017 - 2021</p>
    </form>
    </cfoutput>
  </main>

<cfmodule template="#application.APP_PATH#template/publicFooter.cfm">