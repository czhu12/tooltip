# frozen_string_literal: true

module Users
  class FindAndValidate
    extend LightService::Action

    expects :credentials

    promises :user

    executed do |context|
      user = User.find_for_database_authentication(email: context.credentials.email)
      if user&.valid_password?(context.credentials.password)
        context.user = user
      else
        context.fail!('Invalid email or password combination.')
      end
    rescue StandardError => e
      context.fail!(e.message)
    end
  end
end
