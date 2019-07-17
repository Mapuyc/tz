class Table < ApplicationRecord
  belongs_to :restourant
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :number, presence: true
end
