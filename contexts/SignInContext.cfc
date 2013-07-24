<cfcomponent displayname="SignInContext">
  <cffunction name="init">
    <cfargument name="User" required="True">
    <cfargument name="UserValidator" required="True">
    <cfargument name="UserDataManager" required="True">
    <cfargument name="UserSignInRole" required="True">
      <cfset this.User = arguments.User>
      <cfset this.User.extend(arguments.UserValidator)>
      <cfset this.User.extend(arguments.UserDataManager)>
      <cfset this.User.extend(arguments.UserSignInRole)>
    <cfreturn this>
  </cffunction>

  <cffunction name="execute">
    <cfargument name="UserData" type="Struct" required="True">
    <cfset this.User.fill(UserData)> 
    <cfset errors =  this.User.isValid()>
    <cfif ArrayLen(errors) neq 0>
      <cfreturn {success = False, errors = errors}>
    </cfif>

    <cfset result = this.User.signin()>
    <cfif ArrayLen(result.errors) neq 0>
      <cfreturn {success = False, errors = result.errors}>
    </cfif>
    <cfset session['signInUser'] = result.signInUserDocument>
    <cfreturn {success = True, errors = [], signInUser = result.signInUserDocument}>
  </cffunction>
</cfcomponent>
