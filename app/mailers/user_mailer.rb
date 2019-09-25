class UserMailer < ApplicationMailer

	def registration_email(user)
		@user = user
		mail(to: user.email, subject: 'Welcome')
	end

	def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => 'Password Reset')
  end
end
