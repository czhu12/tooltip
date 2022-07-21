module Types::InputTypes
  class ScriptAttributes < Types::BaseInputObject
    description 'Attributes for creating or updating a script'

    argument :title, String, required: false
    argument :description, String, required: false
    argument :code, String, required: false
    argument :visibility, String, required: false
    argument :slug, String, required: false
  end
end
