module JwtAuthenticatable
  extend ActiveSupport::Concern

  # Required for authentication outside of devise controller
  def generate_new_jti!
    update!(jti: self.class.generate_jti)
  end
end

