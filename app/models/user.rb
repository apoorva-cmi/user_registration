class User < ApplicationRecord
  has_secure_password

  # Callbacks
  before_create :set_username
  after_create :send_successful_registration_email

  # Validations
  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'Only valid emails allowed'
  }

  validates :password_confirmation, presence: true, on: :create
  validates :password, confirmation: true, presence: true,
                       length: { minimum: 8 }, on: :create

  validates :username, length: { minimum: 5 }, on: :update

  private

  def set_username
  	self.username = self.email.split('@').first
  end

  def send_successful_registration_email
  	UserMailer.registration_email(self).deliver_now
  end
end
