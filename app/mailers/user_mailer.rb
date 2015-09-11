class UserMailer < ApplicationMailer

  def loginUser(user)
    @user = user
    @url  = 'http://localhost:3000/login_with_token/?token=' + user.token
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
