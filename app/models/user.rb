class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  def full_address
    "#{street} #{number} #{city} #{postcode}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
