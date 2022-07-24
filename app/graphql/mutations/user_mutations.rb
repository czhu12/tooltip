module Mutations::UserMutations
  class SignUp < Mutations::BaseMutation
    graphql_name 'signUpUser'

    argument :credentials, Types::InputTypes::UserCredentials, required: true

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
end