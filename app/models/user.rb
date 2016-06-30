class User < ActiveRecord::Base
  has_secure_password
  has_many :boxes

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :name, presence: true
end
