# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator" do
        argument :name, String, required: true
    end

    def test_field(name:)
      Rails.logger.info context[:time]

      "Hello #{name}"
    end

    field :author, Types::AuthorType,
          null: true,
          description: 'Returns ine author instance' do
            argument :id, ID, required: true
    end

    def author(id:)
      Author.find(id)
    end

    field :authors, [Types::AuthorType],
          null: false,
          description: "Returns all author instances."

    def authors
      Author.all
    end

    field :user, Types::UserType,
          null: false,
          description: "Returns one author instance." do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    field :users, [Types::AuthorType],
           null: false,
          description: "Returns all author instances."

    def users
      User.all
    end

    field :post, [Types::PostType],
          null: false,
          description: "Returns one post instance." do
      argument :id, ID, required: true
    end

    def post(id:)
      Post.find(id)
    end

    field :posts, [Types::PostType],
          null: false,
          description: "Returns all posts."

    def posts
      Post.all
    end

    field :comment, [Types::CommentType],
          null: false,
          description: "Returns one comment instance." do
      argument :id, ID, required: true
    end

    def comment(id:)
      Comment.find(id)
    end

    field :comments, [Types::CommentType],
          null: false,
          description: "Returns all comments."

    def comments
      Comment.all
    end

    field :login, String, null: true, description: "Returns one login instance." do
      argument :email, String, required: true
      argument :password, String, required: true
    end

    def login(email:, password:)
      if user = UserSession.where(email: email).first&.authenticate(password)
        user.sessions.create.key
      end
    end

    field :current_user, Types::UserSessionType, null: true, description: "Returns one user instance."

    def current_user
      context[:current_user]
    end

    field :logout, Boolean, null: true, description: "Logs out of current session."

    def logout
      Session.where(id: context[:session_id]).destroy_all
      true
    end
  end
end



