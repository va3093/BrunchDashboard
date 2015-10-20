class WelcomeController < ApplicationController
	def index
		@monthToShowString = params[:month]

		if user_signed_in?
			if @monthToShowString
				monthInt = Date::MONTHNAMES.index(@monthToShowString)
				@events = Event.eventsForMonth(monthInt, Time.now.year)
				@prevMonth = Date::MONTHNAMES[monthInt - 1]
				@nextMonth = Date::MONTHNAMES[monthInt + 1]
			else
				@events = Event.eventsForCurrentMonth
				#@events = Event.where("date >= :today", {today: Date.today})
				@prevMonth = 1.month.ago.strftime("%B")
				@nextMonth = 1.month.from_now.strftime("%B")
				@users = User.all
			end
		else
			redirect_to :controller => 'signup', :action => 'index'
		end
	end
end
