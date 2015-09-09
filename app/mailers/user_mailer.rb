class UserMailer < ApplicationMailer

	 default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def loginUser(user)
    @user = user
    @url  = 'localhost://5000/index/' + user.token
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
