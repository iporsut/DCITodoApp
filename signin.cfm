<!DOCTYPE html>
<cfif structKeyExists(form,"signin_submit")>
  <cfset User = createObject("component","models.User").init()>
  <cfset UserValidator = createObject("component","roles.UserSignInValidator")>
  <cfset UserDataManager = createObject("component","roles.UserMysqlManager")>
  <cfset UserSignInRole = createObject("component","roles.UserMysqlSignInRole")>
  <cfset signInContext = createObject("component","contexts.SignInContext").init(User,UserValidator,UserDataManager,UserSignInRole)>

 <cfset result = signInContext.execute(form)>

  <cfif result.success>
    <cflocation url="index.cfm" addtoken="false">
  </cfif>

</cfif>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>SignIn</title>
  </head>
  <body>
    <h1>SignIn</h1>
    <cfif structKeyExists(form,"signin_submit") and not result.success>
      <h3>Errors</h3>
      <cfset errorLen = ArrayLen(result.errors)>
      <cfloop from="1" to="#errorLen#" index="i">
        <p><cfoutput>#result.errors[i]#</cfoutput>
      </cfloop>
    </cfif>
    <form action="" method="POST">
      <p>
        <label for="username">Username</label><br />
        <input type="text" name="username">
      </p>

      <p>
        <label for="password">Password</label><br />
        <input type="password" name="password">
      </p>

      <p>
        <input type="submit" name="signin_submit" value="SignIn">
      </p>
    </form>
  </body>
</html>
