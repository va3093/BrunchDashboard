class Event < ActiveRecord::Base
	has_many :assignments
	has_many :users, through: :assignments

	def remaining_spaces?
		self.number_of_volunteers - self.users.count
	end

	def self.eventsForMonth(month, year)
		events = []
		for i in 1	..5
			eventDate = Event.date_for_nth_sunday(i,month,year)
			if eventDate
				event = Event.find_or_create_by(date: eventDate)
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
	  if n > 1 && date.day < 7
	  	return
	  else
	  	date
	  end

	end
end
