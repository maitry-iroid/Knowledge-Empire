# ke-employee-flutter


app flow for multiple server:

initially for api call , baseUrl will be based on PROD and DEV mode 
- for that I have called `Const.setEnvironment(Environment.DEV);` in main-dev.dart and `Const.setEnvironment(Environment.PROD);` in main-prod.dart.
- using this url I'm calling `verifyCompanyCode` API to get final baseUrl from the server.
- I'll store this new baseUrl in Prefs as a key `mainBaseUrl`. then use it for other apis call including `checkForUpdate` and `login` itself.





