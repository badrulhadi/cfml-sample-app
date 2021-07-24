<cfcontent reset="true">

<cfset req = getHttpRequestData()>
<!--- <cfset req.data = deserializeJSON( req.content )> --->


<cfparam name="req.data.message" default="">
<cfparam name="req.data.date" default="">
<cfparam name="req.data.checksum" default="">


<!--- initialize variables --->
<cfset output = {}>
<cfset output.status = "OK">


<!--- verified http method --->
<cfif req.method neq "POST">
    <cfheader statuscode="405"><!--- method not alowed --->
    <cfabort>
</cfif>


<!--- authentication --->
<cfset key = "F9A9051F-CEB2-129E-8CA3D4DEF3CBAD2A">
<cfset systemChecksum = hmac( 
    req.data.message, 
    key, 
    "HMACSHA256" 
)>

<cfif systemChecksum neq req.data.checksum>
    <cfset output.status = "Error">
    <cfset output.errorMessage = "Unauthorized - Invalid Checksum">
</cfif>


<!--- TODO: check request IP address --->



<!--- validate input --->
<cfif output.status neq "Error">
    <cfif len( req.data.message ) eq 0 >
        <cfset output.status = "Error">
        <cfset output.errorMessage = "Invalid parameter - message">
    </cfif>
    
    <cfif len( req.data.date ) eq 0 or not isValid( "date", req.data.date ) >
        <cfset output.status = "Error">
        <cfset output.errorMessage = "Invalid parameter - date">
    </cfif>
</cfif>

<cfif output.status neq "Error">

    <!--- LOGIC. --->

</cfif>



<!--- RESPONSE --->
<cfoutput>#serializeJSON( output )#</cfoutput>