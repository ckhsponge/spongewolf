class Sponger::User < Sponger::Resource
  def verify_email_address
    Sponger::User.get("verify_email_address/#{self.id}")
  end
end