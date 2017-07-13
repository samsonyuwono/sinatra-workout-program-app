class User < ActiveRecord::Base
  has_secure_password
  has_many :exercises

  validates :username, presence: true
  validates :password, presence: true


end
