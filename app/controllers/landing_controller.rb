class LandingController < ApplicationController
	def index
		render text: "", layout: 'layouts/application.html.erb'		
	end
end
