function fn() {
    
  var configApplication = Java.type('config.configApplication');
  
  var env = karate.env; // get system property 'karate.env'    vs
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev';
  }
  
  var config = { };
  
  if (env == 'dev') {
    config.apiUrl = configApplication.getGlobalValue("apiUrl");
    config.sttUrl = configApplication.getGlobalValue("sttUrl");
    config.userName = configApplication.getGlobalValue("userName");
    config.password = configApplication.getGlobalValue("password");
  }

  return config;
}