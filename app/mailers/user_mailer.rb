class UserMailer < ApplicationMailer

  def loginUser(user)
    @user = user
    base_url = url_for :controller => 'signup', :action => 'log_in_with_token'
    @url  =  "#{base_url}?email=#{user.email}&token=#{user.token}"
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

   def monthlySignupReminder()
    users = User.all
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @events = 	Event.eventsForMonth(Time.now.month + 1, Time.now.year) 
    puts @events
    users.each do |user|
    	base_url = url_for :controller => 'signup', :action => 'log_in_with_token'
    	@url  =  "#{base_url}?email=#{user.email}&token=#{user.token}"
    	@user = user
    	mail(to: user.email, subject: 'Welcome to My Awesome Site')
    end

  end

end
