class Category < ApplicationRecord
  validates :name, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }

  before_save { self.name.downcase! }
end
