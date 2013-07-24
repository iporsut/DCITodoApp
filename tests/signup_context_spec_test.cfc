<cfcomponent displayname="SignUpContextSpec" extends="mxunit.framework.TestCase">
  <cffunction name="setUp">
    <cfset User = createObject("component","models.User").init()>
    <cfset UserValidator = createObject("component","roles.UserValidator")>
    <cfset UserDataManager = createObject("component","tests.UserMongoTestManager")>
    <cfset signUpContext = createObject("component","contexts.SignUpContext").init(User,UserValidator,UserDataManager)>
  </cffunction>

  <cffunction name="tearDown">
    <cfset MongoCollectionDrop(Application.TestDatasource, "user")>
  </cffunction>


  <cffunction name="test_it_should_return_invalid_email" access="public" returntype="void">
    <cfset userData = { email = "singpor", username = "iporsut", password = "password" }>
    <cfset result = signUpContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Email", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_user" access="public" returntype="void">
    <cfset userData = { email = "singpor@gmail.com", username = "6iporsut", password = "password" }>
    <cfset result = signUpContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Username", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_user_short" access="public" returntype="void">
    <cfset userData = { email = "singpor@gmail.com", username = "rsut", password = "password" }>
    <cfset result = signUpContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Username Range", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_user_long" access="public" returntype="void">
    <cfset userData = { email = "singpor@gmail.com", username = "ddddddddddddddddddddd", password = "password" }>
    <cfset result = signUpContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Username Range", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_password_short" access="public" returntype="void">
    <cfset userData = { email = "singpor@gmail.com", username = "iporsut", password = "pas" }>
    <cfset result = signUpContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Password Range", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>

  <cffunction name="test_it_should_return_invalid_password_long" access="public" returntype="void">
    <cfset userData = { email = "singpor@gmail.com", username = "iporsut", password = "passwordddddddddddddddddddddddd" }>
    <cfset result = signUpContext.execute(userData)>
    <cfset assertEquals(1,ArrayLen(result.errors))>
    <cfset assertEquals("Invalid Password Range", result.errors[1])>
    <cfset assertEquals(False, result.success)>
  </cffunction>


  <cffunction name="test_it_should_return_success" access="public" returntype="void">
    <cfset userData = { email = "singpor@gmail.com", username = "iporsut", password = "password" }>
    <cfset result = signUpContext.execute(userData)>
    <cfset assertEquals(0, ArrayLen(result.errors))>
    <cfset assertEquals(True, result.success)>
  </cffunction>

</cfcomponent>
