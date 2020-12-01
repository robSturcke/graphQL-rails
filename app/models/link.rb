class Link < ApplicationRecord
  belongs_to :user, optional: true

  has_many :votes
end
