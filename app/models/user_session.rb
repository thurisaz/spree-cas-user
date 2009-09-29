class UserSession < Authlogic::Session::Base
  persist :persist_by_cas, :if => :authenticating_with_cas?

  #no credentials are passed in: the CAS server takes care of that and saving the session
  #we only validate against the session... shouldn't need to do this, but...
  def credentials=(value)
    values = [:garbage]
    super
  end

  def validate_cas
  end

  def persist_by_cas
    session_key = CASClient::Frameworks::Rails::Filter.client.username_session_key
    if controller.session.key?(session_key) && !controller.session[session_key].blank?


      record = search_for_record("find_by_#{User.cas_user_identifier}", controller.session[session_key])

      unless self.record
       #RELIES ON this method to securely validate that this user request stems from a real user
        record = User.new({:login => controller.session[session_key]})

        if record.login.length > 255
          record = nil
        end
      end

      self.attempted_record = self.unauthorized_record = record
    end

    self.unauthorized_record.nil? ? false : true
  end

  def authenticating_with_cas?
    attempted_record.nil? && errors.empty? && cas_defined?
  end

private
  #todo: validate that cas filters have run.  Authlogic controller adapter doesn't provide access to the filter_chain
  def cas_defined?
    defined?(CASClient::Frameworks::Rails::Filter) && !CASClient::Frameworks::Rails::Filter.config.nil?
  end
end
