require 'rufus-scheduler'


scheduler = Rufus::Scheduler.new

# scheduler.cron('00 12 * * sun#-1') do
# 	users = User.all
#     events = 	Event.eventsForMonth(Time.now.month + 1, Time.now.year) 
#     users.each do |user|
# 		UserMailer.monthlySignupReminder(user,events ).deliver
#     end
# end

scheduler.cron('00 12 * * TUE') do
	Event.remindUsersAboutUpcommingEvent()
end

scheduler.cron('00 12 * * TUE') do
	Event.getPermissionToGetMoreVolunteers()
end

scheduler.cron('00 12 * * 3-6') do
	Event.checkEventVolunteerState()
end