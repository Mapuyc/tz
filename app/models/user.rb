class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :tables, through: :reservations
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }
end
