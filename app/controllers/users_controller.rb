class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
		puts user_params
		@user = User.create(user_params)
		render :nothing => true
	end	

private
	def user_params
	  params.require(:user).permit(:email)
	end	
end
