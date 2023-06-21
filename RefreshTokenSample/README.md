#  Thank you for taking time to review the code

This is a sample application to describe the scenario and 

This does not have any logic nor it displays anything on simulator, the code is to replicate the current codebase structure I'm working on


Requirement: Implement refresh token 
Background: The application uses Okta to login based on feature flag, for simplicity in sample code it uses "isSSOLogin"


After successful login there are bunch of APIs called.[Please see SampleAPI class]
For most of the requests authentication token is mandatory.The authentication token is stored in "DBCredentialsStore"

Question:

[Sample API class - line number 43]
In the current logic while retrieving an auth token we are simply getting it from DBCredential store [Synchronous]

But with Okta - I need to refreshToken if required, by calling "Credential.default.refreshToken" which returns success or failure in the completion closure[Asynchronous]

As refreshing token[Sample API class - line number 60] is an asynchronous call, I tried to pause the flow using a Semaphore so I can continue once the completion block is triggered
