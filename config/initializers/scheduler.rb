require 'rufus-scheduler'


scheduler = Rufus::Scheduler.new

scheduler.cron('00 12 * * sun#-1') do
	users = User.all
    events = 	Event.eventsForMonth(Time.now.month + 1, Time.now.year) 
    users.each do |user|
		UserMailer.monthlySignupReminder(user,events ).deliver
    end
end

scheduler.cron('00 12 * * THU') do
	nextEvent = Event.where("date > ?", Date.today)[0]
	nextEvent.users.each do |user|
		UserMailer.upComingEventReminder(nextEvent,user).deliver
	end
end

scheduler.cron('00 12 * * THU') do
	nextEvent = Event.where("date > ?", Date.today)[0]
	leaders = []
	if nextEvent.users.count < 8 then
		nextEvent.users.each do |user|
			if user.role == "leader"
				leaders << user
			end
		end
		leaders.each do |leader|
			UserMailer.permissionToGetMoreVolunteers(leader, nextEvent.users.count).deliver
		end
	end
end