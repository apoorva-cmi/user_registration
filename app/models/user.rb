class User < ApplicationRecord
  has_secure_password

  # Callbacks
  after_create :send_successful_registration_email

  # Validations
  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'Only valid emails allowed'
  }

  validates :password, confirmation: true, presence: true,
                       length: { minimum: 8 }, on: :create

  private

  def send_successful_registration_email
  	UserMailer.registration_email(self).deliver_now
  end
end
