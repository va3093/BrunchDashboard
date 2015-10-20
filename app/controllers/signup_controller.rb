class SignupController < ApplicationController
  def index
  	@signUpButton = "Log in"
  	@is_new_user = false
  end

  def log_in
  	email = params[:email]
  	first_name = params[:first_name]

    @user = User.find_by(email: email)
  	if @user.nil? then
      if first_name.nil? then
        return redirect_to :controller => 'signup', :action => 'new_user',  :email => email
      else
        @user = User.create(first_name: first_name, email: email)
        @user.save
      end
  	end

    @user.new_token!
    UserMailer.loginUser(@user).deliver_now
  end

  def new_user
  	@signUpButton = "Sign Up"
  	@is_new_user = true
  	@email = params[:email]

  	render('signup/index')
  end

  def log_in_with_token
    email = params[:email]
    token = params[:token]

    @user = User.find_by(email: email, token: token)
    if !@user.nil?
      sign_in @user
      redirect_to :controller => 'welcome', :action => 'index'
    else
      ## Should display an error message, not just show this page!
      render('signup/index')
    end
  end
end
