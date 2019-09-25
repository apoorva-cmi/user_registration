class PasswordResetsController < ApplicationController
  def new
  end

	def create
	  user = User.find_by_email(params[:email])
	  if user.present?
		  user.send_password_reset
		  redirect_to root_url, :notice => "Email sent with password reset instructions."
		else
			redirect_to root_url, :notice => "No user present with this email."
		end
	end

	def edit
	  @user = User.find_by_password_reset_token!(params[:id])
	end

	def update
	  @user = User.find_by_password_reset_token!(params[:id])
	  @user.password = params[:user][:password]
	  @user.password_confirmation = params[:user][:password_confirmation]
	  @user.skip_validation_for_username = true
	  if @user.password_reset_sent_at < 6.hours.ago
	    redirect_to new_password_reset_path, :alert => "Password reset token has expired."
	  elsif @user.save
	    redirect_to root_url, :notice => "Password has been reset."
	  else
	    render :edit
	  end
	end

	private

	def user_params
	    params.require(:user).permit(:password, :password_confirmation)
	  end
end
