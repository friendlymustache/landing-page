class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
		@user = User.create(user_params)
		if @user.valid?
		    # SendEmailJob.set(wait: 3.seconds).perform_later(@user)
			UserMailer.welcome_email(@user).deliver_now
			render json: @user
		else
			render status: :conflict, json: nil
		end
	end	

private
	def user_params
	  params.require(:user).permit(:email, :user_type, :school)
	end	
end
