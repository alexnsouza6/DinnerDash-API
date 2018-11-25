class User < ApplicationRecord
  has_secure_password
  # Validations
  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_uniqueness_of :token

  # Class Methods
  def self.valid_login?(email,password)
    user = User.find_by_email(email)
    user if user&.authenticate(password)
    false
  end
end
