<cfcomponent>
  <cfset this.name = "Todo">
  <cfset this.sessionmanagement = True>
  <cffunction name="onRequestStart">
    <cfset Application.Datasource = "TodoApp">
    <cfif not MongoIsValid(Application.Datasource)>
      <cfset MongoRegister(Application.Datasource, "localhost", 27017, "TodoApp")>
    </cfif>

    <cfset Application.TestDatasource = "TestTodoApp">
    <cfif not MongoIsValid(Application.TestDatasource)>
      <cfset MongoRegister(Application.TestDatasource, "localhost", 27017, "TestTodoApp")>
    </cfif>

    <cfset Application.MysqlDatasource = "todoapp">

  </cffunction>
</cfcomponent>
