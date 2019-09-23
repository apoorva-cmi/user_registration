class UserMailer < ApplicationMailer

	def registration_email(user)
		mail(to: user.email, subject: 'Welcome')
	end
end
