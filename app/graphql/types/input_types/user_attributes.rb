module Types::InputTypes
  class UserAttributes < Types::BaseInputObject
    description 'Attributes for updating a user'

    argument :personal_website, String, required: false
  end
end