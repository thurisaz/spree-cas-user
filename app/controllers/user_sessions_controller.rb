class UserSessionsController < Spree::BaseController
  before_filter :require_user, :only => :destroy
  ssl_required :destroy
  ssl_allowed :login_bar
    
  def new
    raise "Should not create sessions here"
  end

  def create
    raise "Should not create sessions here"
  end

  def destroy
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
  
  def login_bar
    render :partial => "shared/login_bar"
  end
end
