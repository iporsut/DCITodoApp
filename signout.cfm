<cfif StructKeyExists(session, "SignInUser")>
  <cfset StructDelete(session, "SignInUser")>
  <cflocation url="index.cfm" addtoken="false">
</cfif>
