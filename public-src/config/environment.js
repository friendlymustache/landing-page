/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'startup',
    environment: environment,
    baseURL: '/',
    locationType: 'hash',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },
    contentSecurityPolicy: {
      'font-src': "'self' data: fonts.gstatic.com",
      'style-src': "'self' 'unsafe-inline' fonts.googleapis.com",
      'img-src': "*",
      'connect-src' : "*",
      'script-src' : "'self' 'unsafe-inline' www.google-analytics.com",
    },    
  };


  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
    ENV.host = "http://localhost:3000";
    ENV.googleAnalytics = {
        webPropertyId: 'UA-65187916-1',
        tracker: 'analytics_debug.js'
    };

  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.host = "http://ec2-54-68-115-156.us-west-2.compute.amazonaws.com/";
    ENV.googleAnalytics = {
        webPropertyId: 'UA-65187916-2',
        tracker: 'analytics.js'
    };    
  }

  return ENV;
};
