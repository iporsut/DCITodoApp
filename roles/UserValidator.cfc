<cfcomponent displayname="UserValidator">
  <cffunction name="isValid">
    <cfset errors = []>
    <cfif not isValid("email", this.email)>
      <cfset ArrayAppend(errors,"Invalid Email")>
    </cfif>

    <cfif not isValid("regex", this.username, "[a-zA-Z]\w*")>
      <cfset ArrayAppend(errors,"Invalid Username")>
    </cfif>
    <cfif not (Len(this.username) gte 5 and Len(this.username) lte 20)>
      <cfset ArrayAppend(errors,"Invalid Username Range")>
    </cfif>

    <cfif not (Len(this.password) gte 8 and Len(this.password) lte 20)>
      <cfset ArrayAppend(errors,"Invalid Password Range")>
    </cfif>

    <cfif this.has(this.username)>
      <cfset ArrayAppend(errors,"Invalid Account Exists")>
    </cfif>

    <cfreturn errors>
  </cffunction>
</cfcomponent>
