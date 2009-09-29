cas_logger = CASClient::Logger.new(RAILS_ROOT+'/log/cas.log')
cas_logger.level = CASClient::Logger::DEBUG

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "http://cas.football-rich:8080",
  :logger => cas_logger,
  :use_gatewaying => true,
  :enable_single_sign_out => true
)

