<cfcomponent displayname="SignUpContext">
  <cffunction name="init" access="public">
    <cfargument name="User" required="True">
    <cfargument name="UserValidator" required="True">
    <cfargument name="UserDataManager" required="True">
      <cfset this.User = arguments.User>
      <cfset this.User.extend(arguments.UserValidator)>
      <cfset this.User.extend(arguments.UserDataManager)>
    <cfreturn this>
  </cffunction>
  <cffunction name="execute" access="public">
    <cfargument name="UserData" type="Struct" required="True">

    <cfset this.User.fill(UserData)> 

    <cfset errors =  this.User.isValid()>
    <cfif ArrayLen(errors) neq 0>
      <cfreturn {success = False, errors = errors}>
    </cfif>

    <cfset errors = this.User.save()>
    <cfif ArrayLen(errors) neq 0>
      <cfreturn {success = False, errors = errors}>
    </cfif>

    <cfreturn {success = True, errors = []}>
  </cffunction>
</cfcomponent>
