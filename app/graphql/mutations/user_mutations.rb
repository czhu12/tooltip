module Mutations::UserMutations
  class SignUp < Mutations::BaseMutation
    graphql_name 'signUpUser'

    argument :credentials, Types::InputTypes::UserCredentials, required: true
    argument :script_slug, String, required: false

    field :token, String, null: true
    field :errors, String, null: true

    description 'Creates user authentication and returns session token.'

    def resolve(args)
      result = Users::SignUp.call(**args)

      if result.success?
        { token: result.token }
      else
        { errors: result.message }
      end
    end
  end

  class SignIn < Mutations::BaseMutation
    graphql_name 'signInUser'

    argument :credentials, Types::InputTypes::UserCredentials, required: true

    field :token, String, null: true
    field :errors, String, null: true

    description 'Authenticates user and returns session token.'

    def resolve(args)
      result = Users::Authenticate.call(args)

      if result.success?
        { token: result.token }
      else
        { errors: result.message }
      end
    end
  end

  class UpdateUser < Mutations::BaseMutation
    include Graphql::Pundit::Authorize

    graphql_name 'updateCurrentUser'

    argument :id, ID, loads: Types::ModelTypes::UserType, as: :user, required: true
    argument :attributes, Types::InputTypes::UserAttributes, required: true

    field :user, Types::ModelTypes::UserType, null: true
    field :errors, String, null: true

    pundit_role :update?
    pundit_policy_class UserPolicy

    description 'Updates existing user'

    def resolve(args)
      authorize!(args[:user])

      result = Users::Update.execute(args)

      if result.success?
        { user: result.user }
      else
        { errors: result.message }
      end
    end
  end
end