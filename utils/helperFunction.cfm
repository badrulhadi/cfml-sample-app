<cfscript>
	request.helper = StructNew();
	
	boolean function hasRole( string role )
	{
		if ( arrayFind( session.vars.roles, arguments.role )) {
			return true;
		}
	
		return false;
	}
	request.helper.hasRole = hasRole;
	
	
	boolean function hasPermission( string permission )
	{
		if ( arrayFind( session.vars.permissions, arguments.permission )) {
			return true;
		}
	
		return false;
	}
	request.helper.hasPermission = hasPermission;
	
	
	string function generateRandomString(numeric length, chars="ABCDEFGHIJKLMNOPQRST0123456789@##$&") {
		var i = 0;
		var theString = "";
		for (i = 0; i < length; i++) {
			theString &= Mid(chars, RandRange(1, len(chars), "SHA1PRNG"), 1);
		}
		return theString;
	}
	request.helper.generateRandomString = generateRandomString;
</cfscript>