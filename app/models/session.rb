class Session < ApplicationRecord
  belongs_to :user_session

  before_create do
    self.key = SecureRandom.hex(64)
  end
end
