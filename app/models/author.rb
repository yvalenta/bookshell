class Author < ApplicationRecord

  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def coordinates
    [rand(90), rand(90)]
  end

  def publication_years
    (1..rand(10)).to_a.map { 1900 - rand(100) }
  end
end
