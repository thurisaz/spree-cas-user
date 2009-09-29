= Rubycas SSO

This extension requires the Rubycas-client plugin (and a working CAS server with which it will communicate) for CAS authentication.  You can get this plugin at http://code.google.com/p/rubycas-client/  By installing and configuring your CAS client as found in initializers/cas_config.rb, you should present the session variable session[:cas_user].

This module extends Authlogic to log in with the user provided by the cas server.  It will create the user locally if it does not exist, so existing joins and references to Spree users continue to work.  All other Authlogic functions used in Spree should continue to work properly.

