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

        first_name_array = first_name.gsub(/\s+/m, ' ').strip.split(" ")
        name = ""
        last_name = ""
        if first_name_array.count > 1 then
          name = first_name_array[0] 
          las_name = first_name_array[1]
        else
          name = first_name_array[0]
        end

        @user = User.create(first_name: name, last_name:last_name, email: email)
        UserMailer.welcomeEmail(@user).deliver_now

      end
  	end
    if @user.token.nil? then
      @user.new_token!
    end 
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
