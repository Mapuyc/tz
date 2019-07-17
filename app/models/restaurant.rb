class Restaurant < ApplicationRecord
  has_many :tables
  validates :name, uniqueness: true
end
