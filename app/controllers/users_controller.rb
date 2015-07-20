class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
		@user = User.create(user_params)
		if @user.valid?
		    mailchimp = Mailchimp::API.new(ENV['http_MAILCHIMP_API_KEY'])
		    mailchimp.lists.subscribe(ENV['http_MAILCHIMP_LIST_ID'],
                   {email: @user.email}, {
					"USERTYPE" => @user.user_type,
					"SCHOOL" => @user.school
                   	}, 'html', false)
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
