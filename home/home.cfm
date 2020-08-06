<cfmodule template="#application.APP_PATH#/customTags/header.cfm">

<main role="main" class="container">

    <div class="starter-template">
        <h1> home</h1>  
        
        <p class="lead">Use this document as a way to quickly start any new project.<br> All you get is this text and a mostly barebones HTML document.</p>
    </div>
  
    <cfdump var="#session#" expand="true">
    <cfdump var="#application#" expand="true">
</main><!-- /.container -->


<cfmodule template="#application.APP_PATH#/customTags/footer.cfm">
