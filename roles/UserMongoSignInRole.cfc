<cfcomponent name="UserMongoSignInRole">
  <cffunction name="signin">
    <cfset errors = []>
    <cfset hashPassword = Hash(this.password, "MD5")>
    <cfset result = MongoCollectionFind(datasource = Application.Datasource,collection =  "user",
                      query = { $and = [{username = this.username}, {password = hashPassword}] }
    )>
    <cfif ArrayLen(result) lte 0>
      <cfreturn {errors = ["Invalid Username or Password"]}>
    </cfif>
    <cfreturn {errors = [], signInUserDocument = result}>
  </cffunction>
</cfcomponent>
