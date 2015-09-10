class UserMailer < ApplicationMailer

	 default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def loginUser(user)
    @user = user
    @url  = 'http://localhost:3000/login_with_token/?token=' + user.token
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
