class WelcomeController < ApplicationController
	def index
		@user = User.find_by(id: session[:current_user_id])
		puts @user
		if @user 
				
		else 
			redirect_to :controller => 'signup', :action => 'index'
		end

	end
end
