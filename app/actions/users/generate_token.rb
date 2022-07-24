# frozen_string_literal: true

module Users
  class GenerateToken
    extend LightService::Action

    expects :user

    promises :token

    executed do |context|
      context.user.generate_new_jti!

      context.token, = Warden::JWTAuth::UserEncoder.new.call(
        context.user, :user, nil
      )
    rescue StandardError => e
      context.fail!(e.message)
    end
  end
end
