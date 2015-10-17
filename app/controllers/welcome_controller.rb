class WelcomeController < ApplicationController
	def index
		@user = User.find_by(id: session[:current_user_id])
		@monthToShowString = params[:month]
		
		if @user
			if @monthToShowString
				@events = Event.eventsForMonth(@monthToShowString, Time.now.year)
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
