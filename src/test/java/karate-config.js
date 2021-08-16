function fn() {
    
  var configApplication = Java.type('config.configApplication');
  
  var config = {
    apiUrl: configApplication.getGlobalValue("apiUrl"),
    sttUrl: configApplication.getGlobalValue("sttUrl"),
    userName: configApplication.getGlobalValue("userName"),
    password: configApplication.getGlobalValue("password")
  }
  return config;
}