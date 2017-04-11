class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  # User associations with doctor, appointments and patients.. A user has one doctor and many appointments and patients
  has_one :doctor, dependent: :destroy
  has_many :appointments
  has_many :patients

  def send_devise_notification(notification, *args)
  if Rails.env.production?
    # No worker process in production to handle scheduled tasks
    devise_mailer.send(notification, self, *args).deliver_now
  else
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
end
