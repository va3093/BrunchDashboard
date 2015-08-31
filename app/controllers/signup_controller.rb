class SignupController < ApplicationController
  def index

  	@signUpButton = "Log in"
  	@signUpAction = "log_in"
  	@email 
  	@first_name
  	@isCurrentUser = true
  end

  def log_in 
  	@email = params[:email]
  	@first_name = params[:first_name]
  	puts params
  	@user = User.find_by(email: @email)
  	if !@user
		redirect_to :controller => 'signup', :action => 'new_user',  :email => @email
  	end
  end

  def new_user 
  	@signUpButton = "Sign Up"
  	@signUpAction = "sign_up"
  	@isCurrentUser = false
  	@email = params[:email]
  	puts params	
  	render('signup/index')

  end

  def sign_up
  	render('welcome/index')
  	puts "about to login"
  end
end
