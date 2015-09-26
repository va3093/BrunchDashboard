class UserMailer < ApplicationMailer

  def loginUser(user)
    @user = user
    base_url = url_for :controller => 'signup', :action => 'log_in_with_token'
    @url  =  "#{base_url}?token=#{user.token}"
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
