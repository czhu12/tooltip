# frozen_string_literal: true

module Users
  class Create
    extend LightService::Action

    expects :credentials

    promises :user

    executed do |context|
      context.user = User.create!(
        User.attributes_from_graphql_input(context.credentials)
      )
    rescue StandardError => e
      context.fail!(e.message)
    end
  end
end
