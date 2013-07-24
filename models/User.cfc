<cfcomponent displayname="User">
  <cfset this.email = "">
  <cfset this.username = "">
  <cfset this.password = "">
  <cfinclude template="/extend.cfm" runonce="true">
  <cffunction name="init">
    <cfreturn this>
  </cffunction>
  <cffunction name="fill" returntype="void">
    <cfargument name="userData" required="true">
    <cfif StructKeyExists(arguments.userData, "email")>
      <cfset this.email = arguments.userData.email>
    </cfif>
    <cfif StructKeyExists(arguments.userData, "username")>
      <cfset this.username = arguments.userData.username>
    </cfif>
    <cfif StructKeyExists(arguments.userData, "password")>
      <cfset this.password = arguments.userData.password>
    </cfif>
  </cffunction>
  <cffunction name="getStruct" returntype="struct">
    <cfreturn {email = this.email, username = this.Username, password = this.password}>
  </cffunction>
</cfcomponent>
