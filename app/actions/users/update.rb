
# frozen_string_literal: true

module Users
  class Update
    extend LightService::Action

    expects :user
    expects :attributes, default: {}

    promises :user

    executed do |context|
      context.user.update!(
        User.attributes_from_graphql_input(context.attributes)
      )
    rescue StandardError => e
      context.fail!(e.message)
    end
  end
end