# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class CasUserExtension < Spree::Extension
  version "1.0"
  description "Authenticate with Rubycas authentication server for single sign-on"
  url "http://yourwebsite.com/cas_user"

  def activate
    session_tmp = "#{RAILS_ROOT}/tmp/sessions" 
    FileUtils.mkdir_p session_tmp unless File.directory?(session_tmp)

    User.extend ClassMethods

    User.class_eval do
      attr_accessible :login

      def set_login; end
    end

    Spree::BaseController.class_eval do
      before_filter CASClient::Frameworks::Rails::GatewayFilter
    end
  end

  module ClassMethods
    def cas_user_identifier(value = nil)
      rw_config :cas_user_identifier, value, 'login'
    end
    alias_method :cas_user_identifier=, :cas_user_identifier
  end
end
