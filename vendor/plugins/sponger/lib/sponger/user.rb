class Sponger::User < Sponger::Resource
  def verify_email_address
    Sponger::User.put("#{self.id}/verify_email_address")
  end
end