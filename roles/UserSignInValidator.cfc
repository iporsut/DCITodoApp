<cfcomponent displayname="UserSignInValidator">
  <cffunction name="isValid">
    <cfset errors = []>
   <cfif not isValid("regex", this.username, "[a-zA-Z]\w*")>
      <cfset ArrayAppend(errors,"Invalid Username")>
    </cfif>
    <cfif not (Len(this.username) gte 5 and Len(this.username) lte 20)>
      <cfset ArrayAppend(errors,"Invalid Username Range")>
    </cfif>

    <cfif not (Len(this.password) gte 8 and Len(this.password) lte 20)>
      <cfset ArrayAppend(errors,"Invalid Password Range")>
    </cfif>
    <cfreturn errors>
  </cffunction>
</cfcomponent>
