# frozen_string_literal: true

module Users
  class SignUp
    extend LightService::Organizer

    def self.call(args)
      with(args).reduce(actions)
    end

    def self.actions
      [
        Users::Create,
        Users::GenerateToken
      ]
    end
  end
end