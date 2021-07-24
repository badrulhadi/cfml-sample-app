component {

	this.name = "Boilerplate-v0.0.1";
	this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0); //10 days
	
	this.sessionManagement = true;
	this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0); //30 minutes
	this.setClientCookies = true;
	// this.scriptProtect = "ALL";
	this.datasource = "app_db_dev";
	// this.ormEnabled = true;
	// this.ormSettings = {
	// 	dbcreate = "dropcreate",
	// 	dialect = "MicrosoftSQLServer",
	// 	CFCLocation = "model"
	// };

	this.baseDirectory = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/utils" ] = (this.baseDirectory & "utils/");
	this.mappings[ "/template" ] = (this.baseDirectory & "template/");

	// this.mappings = {
    //     "/foo" = expandPath('/com/myCompany/foo')
    // };

	function onApplicationStart() {
		application.APP_NAME = "cfml-boilerplate";
		application.APP_PATH = "/#application.APP_NAME#/";
		application.APP_URL = "http://#cgi.server_name#/#application.APP_NAME#/";
		application.APP_DSN = "app_db_dev";

		return true;
	}

	function onSessionStart() {}

	/**
	 * the target page is passed in for reference,
	 * but you are not required to include it
	 */
	function onRequestStart(string targetPage) {
		if (not findNoCase("/index.cfm", cgi.script_name)and NOT findNoCase("/api/", cgi.script_name)) {
			location("index.cfm", false);
		}

		if (structKeyExists(url, 'init')) {
			onApplicationStart();
		}

		if (structKeyExists(url, 'reloadOrm')) {
			onApplicationStart();
			ormReload();
		}

		cfinclude(template="/utils/helperFunction.cfm")
		parseAction();
	}

	function onRequest(string targetPage) {
		include arguments.targetPage;
	}

	function onRequestEnd() {}

	function onSessionEnd(struct SessionScope, struct ApplicationScope) {}

	function onApplicationEnd(struct ApplicationScope) {}

	function onError(any Exception, string EventName) {

		if (structKeyexists(Exception, "cause") and structKeyexists(Exception.cause, "errorCode")) {
			if (Exception.cause.errorCode eq "NOLOGIN") {
				location("index.cfm", false);
			}

			if (Exception.cause.errorCode eq "NODIRECT") {
				cfheader(statuscode = "404");
				abort;
			}

			if (Exception.cause.errorCode eq "ACCESSDENIED") {
				cfheader(statuscode = "403");
				abort;
			}

			if (Exception.cause.errorCode eq "CSRFATTACK") {
				writeDump("YOU GOT HACKED. PUT SOME CSRF TOKEN PLEASEE!!!!!");
				abort;
			}
		}

		cfcontent(reset = "true");

		// include "error.cfm";
		writeDump(Exception);
		writeDump(EventName);
		writeDump(application);
		writeDump(cgi);
		writeDump(session);
		abort;
	}

	function onMissingTemplate() {
		return false;
	}

	private void function parseAction() {
		attributes.appmodule = "";
		attributes.appaction = "";

		for (param in listToArray(cgi.QUERY_STRING, "&")) {

			if (listLen(param, "=") eq 2) {
				var paramName = listGetAt(param, 1, '=');
				var paramValue = listGetAt(param, 2, '=');
				
				attributes[paramName] = paramValue;
			}
		}	
	}

}