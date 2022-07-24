# frozen_string_literal: true

module Users
  class Authenticate
    extend LightService::Organizer

    def self.call(args)
      with(args).reduce(actions)
    end

    def self.actions
      [
        Users::FindAndValidate,
        Users::GenerateToken,
      ]
    end
  end
end
