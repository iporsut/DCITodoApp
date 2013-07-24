<!DOCTYPE html>
<cfif structKeyExists(form,"signup_submit")>
  <cfset User = createObject("component","models.User").init()>
  <cfset UserValidator = createObject("component","roles.UserValidator")>
  <cfset UserDataManager = createObject("component","roles.UserMysqlManager")>

  <cfset signUpContext = createObject("component","contexts.SignUpContext").init(User,UserValidator,UserDataManager)>

  <cfset result = signUpContext.execute(form)>

  <cfif result.success>
    <cflocation url="success.cfm" addtoken="false">
  </cfif>

</cfif>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>SignUp</title>
  </head>
  <body>
    <h1>SignUp</h1>
    <cfif structKeyExists(form,"signup_submit") and not result.success>
      <h3>Errors</h3>
      <cfset errorLen = ArrayLen(result.errors)>
      <cfloop from="1" to="#errorLen#" index="i">
        <p><cfoutput>#result.errors[i]#</cfoutput>
      </cfloop>
    </cfif>
    <form action="" method="POST">
      <p>
        <label for="email">Email</label><br />
        <input type="text" name="email">
      </p>

      <p>
        <label for="username">Username</label><br />
        <input type="text" name="username">
      </p>

      <p>
        <label for="password">Password</label><br />
        <input type="password" name="password">
      </p>

      <p>
        <input type="submit" name="signup_submit" value="SignUp">
      </p>
    </form>
  </body>
</html>
