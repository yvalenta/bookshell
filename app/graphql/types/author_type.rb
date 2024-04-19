module Types
  class AuthorType < Types::BaseObject
    description 'one author'

    field :id, ID, null: false
    field :first_name, String, null: true, camelize: true
    field :last_name, String, null: true
    field :yob, Int, null: false
    field :is_alive, Boolean, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false

    field :full_name, String, null: false

    field :coordinates, Types::CoordinatesType, null: true

    field :publication_years, [Int], null: false

    field :errors, [Types::ErrorType], null: true

    def errors
      object.errors.map { |field| { field_name: field.attribute, errors: object.errors[field.attribute] } }
    end

    def self.authorized?(object, context)
      !object.is_alive?
    end
  end

  class Types::AuthorInputType < GraphQL::Schema::InputObject
    graphql_name 'AuthorInputType'
    description 'All the attributes needed to create/update an author'

    argument :id, ID, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :yob, Int, required: false
    argument :is_alive, Boolean, required: false
  end
end
