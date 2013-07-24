<cfif StructKeyExists(session, "SignInUser")>
  Yeah <a href="signout.cfm">SignOut</a>
<cfelse>
  No! <a href="signin.cfm">SignIn</a> or <a href="signup.cfm">SignUp</a>
</cfif>
