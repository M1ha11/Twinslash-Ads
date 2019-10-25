class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true, length: { minimum: 5 }   

  extend Enumerize
  enumerize :role, in: [:user, :admin], default: :user

  has_many :advertisments
end
