class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :rememberable
         #:recoverable,
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_one_attached :profile_image
end
