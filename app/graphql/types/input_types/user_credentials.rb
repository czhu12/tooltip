module Types::InputTypes
  class UserCredentials < Types::BaseInputObject
    description 'Attributes for creating or updating a user'

    argument :email, String, required: true
    argument :password, String, required: true
    argument :username, String, required: false
  end
end