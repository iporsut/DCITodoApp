<cfcomponent displayname="SignInContextSpec" extends="mxunit.framework.TestCase">
  <cffunction name="setUp">
    <cfset MongoCollectionInsert(datasource = Application.TestDatasource,
            collection = "user",
            data = { email = "singpor@gmail.com" , username = "iporsut", password = Hash("password", "MD5") }
            )
    >
    <cfset User = createObject("component","models.User").init()>
    <cfset UserValidator = createObject("component","roles.UserSignInValidator")>
    <cfset UserDataManager = createObject("component","tests.UserMongoTestManager")>
    <cfset UserSignInRole = createObject("component","tests.UserMongoTestSignInRole")>
    <cfset signInContext = createObject("component","contexts.SignInContext").init(User,UserValidator,UserDataManager,UserSignInRole)>
  </cffunction>

  <cffunction name="tearDown">
    <cfset MongoCollectionDrop(Application.TestDatasource, "user")>
    <cfif StructKeyExists(session, "signInUser")>
      <cfset StructDelete(session, "SignInUser")>
    </cfif>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_user" access="public" returntype="void">
    <cfset userData = { username = "6iporsut", password = "password" }>
    <cfset result = signInContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Username", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_user_short" access="public" returntype="void">
    <cfset userData = { username = "rsut", password = "password" }>
    <cfset result = signInContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Username Range", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_user_long" access="public" returntype="void">
    <cfset userData = { username = "ddddddddddddddddddddd", password = "password" }>
    <cfset result = signInContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Username Range", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_password_short" access="public" returntype="void">
    <cfset userData = { username = "iporsut", password = "pas" }>
    <cfset result = signInContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Password Range", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_password_long" access="public" returntype="void">
    <cfset userData = { username = "iporsut", password = "passwordddddddddddddddddddddddd" }>
    <cfset result = signInContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Password Range", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>


  <cffunction name="test_it_should_return_success" access="public" returntype="void">
    <cfset userData = { username = "iporsut", password = "password" }>
    <cfset result = signInContext.execute(userData)>
    <cfset assertEquals(0, ArrayLen(result.errors))>
    <cfset assertEquals(True, result.success)>
    <cfset assertEquals("Yes", StructKeyExists(session, "signInUser"))>
  </cffunction>

</cfcomponent>
