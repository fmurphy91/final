class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # User associations with doctor, appointments and patients.. A user has one doctor and many appointments and patients
  has_one :doctor, dependent: :destroy
  has_many :appointments
  has_many :patients
end
