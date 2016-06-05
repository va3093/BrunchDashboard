class Event < ActiveRecord::Base
	has_many :assignments
	has_many :users, through: :assignments

	validates :date, presence: true
	validates :last_checked_volunteer_count, presence: true
	#validates :number_of_volunteers, presence: true

	def remaining_spaces?
		self.users.count
		#self.number_of_volunteers - self.users.count
	end

	def self.eventsForMonth(month, year)
		events = []
		for i in 0 ..5
			eventDate = Event.date_for_nth_sunday(i,month,year)
			if eventDate
				event = Event.find_or_create_by(date: eventDate)
				puts event.id
				events << event
			end
		end
		events
	end

	def self.eventsForCurrentMonth
		Event.eventsForMonth(Time.now.month, Time.now.year)
	end

	def self.date_for_nth_sunday(n,month,year)
	  # get the last day of the month
	  date = Date.new year, month, 1
	  #subtract number of days we are ahead of sunday
	  date += ((7 * n) - date.wday)
	  if n > 1 && date.day < 7 || date.month != month
	  	return
	  else
	  	date
	  end

	end

	def self.event_of_next_sunday()
	  date  = Date.parse("Sunday")
	  delta = date > Date.today ? 0 : 7
	  new_date = date + delta
	  return Event.where("date = ?", new_date.beginning_of_day.to_s())
	end

	def self.remindUsersAboutUpcommingEvent
		events = Event.event_of_next_sunday()
		if events.count > 0 
			nextEvent = events[0]
			nextEvent.users.each do |user|
				UserMailer.upComingEventReminder(nextEvent,user).deliver
			end
		end
	end

	def self.getPermissionToGetMoreVolunteers() 
		events = Event.event_of_next_sunday()
		leaders = []
		if events.count > 0 
			nextEvent = events[0]
			if nextEvent.users.count < Rails.application.config.min_number_of_volunteers then
				nextEvent.users.each do |user|
					if user.role == "leader"
						leaders << user
					end
				end
				leaders.each do |leader|
					UserMailer.permissionToGetMoreVolunteers(leader, nextEvent).deliver
				end
			end
		end
	end

	def self.checkEventVolunteerState(event=nil)
		event = event || Event.event_of_next_sunday()[0]
		if event.last_checked_volunteer_count != nil && event.users.count < event.last_checked_volunteer_count 
			leaders = Event.leadersForEvent(event)
			leaders.each do |leader|
				UserMailer.eventVolutneerStateHasChanged(leader, event, event.last_checked_volunteer_count, event.users.count).deliver_now
			end
		end	
		event.last_checked_volunteer_count = event.users.count
		event.save()
	end 

	def self.leadersForEvent(event)
		leaders = []
		event.users.each do |user|
			if user.role == "leader"
				leaders << user
			end
		end
		return leaders
	end
end


