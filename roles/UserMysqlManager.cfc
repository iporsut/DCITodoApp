<cfcomponent displayname="UserMysqlManager">
  <cffunction name="save">
    <cfset errors = []>
    <cfset data = this.getStruct()>
    <cfset data['password'] = Hash(data.password, 'MD5')>
    <cfquery name="save_user" datasource="#Application.MysqlDatasource#">
      insert into user(email, username, password) values
        (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#data.email#">,
         <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#data.username#">,
         <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#data.password#">)
    </cfquery>
    <cfreturn errors>
  </cffunction>
  <cffunction name="has">
    <cfset data = this.getStruct()>
    <cfset data['password'] = Hash(data.password, 'MD5')>

    <cfquery name="has_user" datasource="#Application.MysqlDatasource#">
      select id from user where email like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#data.email#">
      and password like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#data.password#">
    </cfquery>
    <cfif not QueryIsEmpty(has_user)>
      <cfreturn true>
    </cfif>
 
    <cfreturn false>
  </cffunction>
</cfcomponent>
