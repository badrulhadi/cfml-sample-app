
component {
    
    /**
     * validate user input password if it is same as hash password stored in DB
     *
     * @plainPassword   user input password in plaintext
     * @hashPassword    hash value password retrieve from database
     * @salt            password salt from database
     */
    public boolean function verifyPassword( string plainPassword, string hashPassword, string salt )
    {
        var newHashPassword = this.hashPassword( arguments.plainPassword, arguments.salt );

        return newHashPassword eq arguments.hashPassword;
    }


    /**
     * hash password by concatenating password with salt
     *
     * @plainPassword   paintext password
     * @salt            password salt
     */
    public string function hashPassword( string plainPassword, string salt )
    {
        return hash( arguments.plainPassword & arguments.salt, "SHA-512");
    }


    /**
     * generate random password
     *
     * @length  length of generated password
     * @chars   list of characters to choose from
     */
    public string function generatePassword( numeric length, chars="ABCDEFGHIJKLMNOPQRST0123456789@##$&" )
    {
        var i = 0;
        var theString = "";

        for (i = 0; i < length; i++) {
            theString &= Mid(chars, RandRange(1, len(chars), "SHA1PRNG"), 1);
        }

        return theString;
    }

    /**
     * generate password salt
     */
    public string function generateSalt()
    {
        return hash( GenerateSecretKey( "AES" ), "SHA-512" );
    }


    /**
     * get security policy
     *
     * @policyName name of security policy
     */
    public any function getSecurityPolicy( string policyName )
    {
        var policy = queryExecute("
            SELECT iValue
            FROM SecurityPolicy
            WHERE vaPolicyName = :policyName",
            {policyName = {value=arguments.policyName, cfsqltype="cf_sql_nvarchar"}}
        );

        return policy.iValue;
    }

}