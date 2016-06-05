class UserMailer < ApplicationMailer

  def loginUser(user)
    @user = user
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    base_url = url_for :controller => 'signup', :action => 'log_in_with_token'
    @url  =  "#{base_url}?email=#{user.email}&token=#{user.token}"
    mail(to: @user.email,bcc: ["va3093@gmail.com"], subject: 'Brunch Dashboard: Login')
  end

  def monthlySignupReminder(user, events)
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @events =  events     
    @user = user
    @base_remove_url = url_for :controller => 'welcome', :action => 'remove_from_month'
    @add_url = url_for :controller => 'welcome', :action => 'sign_up_month'
    mail(to: user.email, bcc: ["va3093@gmail.com"], subject: 'Brunch Dashboard: Next Month')
    

  end

  def currentMonthSignupReminder(user, events)
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @events =  events     
    @user = user
    @base_remove_url = url_for :controller => 'welcome', :action => 'remove_from_month'
    @add_url = url_for :controller => 'welcome', :action => 'sign_up_month'
    mail(to: user.email, bcc: ["va3093@gmail.com"], subject: 'Brunch Dashboard: Sign up reminder')
    

  end

  def upComingEventReminder(event, user)
    @nextEvent = event
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @base_remove_url = url_for :controller => 'welcome', :action => 'remove_from_month'

    @user = user
    mail(to: user.email, bcc: ["va3093@gmail.com"], subject: 'Brunch Dashboard: Reminder')

  end

  def usersNotComingAlertMail(leader,user,event)
    # attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    # @user = user
    # @leader = leader
    # @event = event
    # mail(to: leader.email, bcc: ["va3093@gmail.com"], subject: "Brunch Dashboard: #{@user.first_name} has pulled out")

  end

  def welcomeEmail(user)
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @user = user
    mail(to: user.email, bcc: ["va3093@gmail.com"], subject: 'Brunch Dashboard: Welcome')

  end

  def permissionToGetMoreVolunteers(leader, event)
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @leader = leader
    @count = event.users.count
    @get_more_volunteers_email_url = url_for :controller => 'general_message', :action => 'message', :redirect_controller => 'welcome', :redirect_action => 'get_more_volunteers', :redirect_params => {:event_id => event.id, :token => leader.token}, :redirect_button_text => "Send the emails", :message => "Are you sure you want to send an email asking for more help? This will email all #{User.all.count} brunch volunteers asking for a few more signups for this week. Before you send this make sure that another leader has not already told me to send these emails."
    mail(to: leader.email, bcc: ["va3093@gmail.com"], subject: 'Brunch Dashboard: Should I get more volunteers')
  end

  def needVolunteersEmail(user, event)
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @user = user
    @event = event
    @add_url = url_for :controller => 'welcome', :action => 'sign_up_month'    
    mail(to: user.email, bcc: ["va3093@gmail.com"], subject: 'Brunch Dashboard: Need some help this weekend')
  end

  def eventVolutneerStateHasChanged(leader, event, last_count, current_count)
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    @leader = leader
    @event = event
    @last_count = last_count
    @current_count = current_count
    @get_more_volunteers_email_url = url_for :controller => 'general_message', :action => 'message', :redirect_controller => 'welcome', :redirect_action => 'get_more_volunteers', :redirect_params => {:event_id => event.id, :token => leader.token}, :redirect_button_text => "Send the emails", :message => "Are you sure you want to send an email asking for more help? This will email all #{User.all.count} brunch volunteers asking for a few more signups for this week. Before you send this make sure that another leader has not already told me to send these emails."
    mail(to: leader.email, bcc: ["va3093@gmail.com"], subject: 'Brunch Dashboard: Leaders update')
  end

end
