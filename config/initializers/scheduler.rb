require 'rufus-scheduler'


scheduler = Rufus::Scheduler.new


# scheduler.every '1m' do
#   UserMailer.monthlySignupReminder().deliver_now
# end