class User < ApplicationRecord
  has_secure_password

  attr_accessor :skip_validation_for_username

  # Callbacks
  before_create :set_username
  after_create :send_successful_registration_email

  # Validations
  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'Only valid emails allowed'
  }

  validates :password_confirmation, presence: true
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }

  validates :username, length: { minimum: 5 }, on: :update, unless: :skip_validation_for_username

	def send_password_reset
	  self.update_column(:password_reset_token, generate_token)
	  self.update_column(:password_reset_sent_at, Time.zone.now)
	  UserMailer.password_reset(self).deliver_now
	end

	def generate_token
    SecureRandom.urlsafe_base64
  end

  private

  def set_username
  	self.username = self.email.split('@').first
  end

  def send_successful_registration_email
  	UserMailer.registration_email(self).deliver_now
  end
end
