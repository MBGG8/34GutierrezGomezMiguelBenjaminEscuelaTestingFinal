function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev';
  }

  if (env == 'dev') {
    petStore = 'https://petstore.swagger.io/v2/'
  } else if (env == 'e2e') {
    // customize
  }

  var config = {
    env: env,
    myVarName: 'someValue',
    petStore: petStore
  }
  return config;
}