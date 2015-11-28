class Event < ActiveRecord::Base
	has_many :assignments
	has_many :users, through: :assignments

	validates :date, presence: true
	#validates :number_of_volunteers, presence: true

	def remaining_spaces?
		self.users.count
		#self.number_of_volunteers - self.users.count
	end

	def self.eventsForMonth(month, year)
		events = []
		for i in 1	..5
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
	  if n > 1 && date.day < 7
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
end
