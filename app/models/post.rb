class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user

  # def comments
  #   self.comments.order(created_at: :desc)
  # end
end
