class UserMailer < ApplicationMailer

  def loginUser(user)
    @user = user
    base_url = url_for :controller => 'signup', :action => 'log_in_with_token'
    @url  =  "#{base_url}?email=#{user.email}&token=#{user.token}"
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

   def monthlySignupReminder(user, events)
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @events =  events     
    @user = user
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
    

  end

  def upComingEventReminder(event, user)
    @nextEvent = event
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @user = user
    mail(to: user.email, subject: 'Welcome to My Awesome Site')

  end

  def usersNotComingAlertMail(leader,user)
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @user = user
    @leader = leader
    mail(to: leader.email, subject: 'Welcome to My Awesome Site')

  end

end
