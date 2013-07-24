<cfcomponent displayname="UserMongoManager">
  <cffunction name="save">
    <cfset errors = []>
    <cfset data = this.getStruct()>
    <cfset data['password'] = Hash(data.password, 'MD5')>
    <cfset MongoCollectionInsert(Application.Datasource,"user",data)>
    <cfreturn errors>
  </cffunction>
  <cffunction name="has">
    <cfif ArrayLen(MongoCollectionFind(datasource = Application.Datasource, collection = "user", query =  {$or = [{email = this.email}, {username = this.username}]})) gt 0>
      <cfreturn true>
    </cfif>

    <cfreturn false>
  </cffunction>
</cfcomponent>
