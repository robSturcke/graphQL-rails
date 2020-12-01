module Types
  class VoteType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :link, Types::LinkType, null: false
  end
end
