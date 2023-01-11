function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'debi@gmail.com'
    config.userPass = 'debi'
  } else if (env == 'e2e') {
    config.userEmail = 'debi2@gmail.com'
    config.userPass = 'debi2'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', { Authorization: 'Token ' + accessToken })

  return config;
}