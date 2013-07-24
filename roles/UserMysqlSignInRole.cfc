<cfcomponent name="UserMysqlSignInRole">
  <cffunction name="signin">
    <cfset errors = []>
    <cfset hashPassword = Hash(this.password, "MD5")>
    
    <cfquery name="result" datasource="#Application.MysqlDatasource#">
      select id from user where username like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.username#">
      and password like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#hashPassword#">
    </cfquery>

    <cfif QueryIsEmpty(result)>
      <cfreturn {errors = ["Invalid Username or Password"]}>
    </cfif>
    <cfreturn {errors = [], signInUserDocument = result}>
  </cffunction>
</cfcomponent>
