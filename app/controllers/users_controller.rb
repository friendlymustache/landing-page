class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
		@user = User.create(user_params)
		puts "Created user!"
	    # SendEmailJob.set(wait: 3.seconds).perform_later(@user)
		UserMailer.welcome_email(@user).deliver_now
		render :nothing => true
	end	

private
	def user_params
	  params.require(:user).permit(:email, :user_type)
	end	
end
