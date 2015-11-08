class WelcomeController < ApplicationController
	def index
		@monthToShowString = params[:month]
		puts params
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

	def sign_up_month
		user = User.find_by_id(params[:userId]) || current_user
		event = Event.find_by_id(params[:event_id])
		event.users << user

		redirect_to :controller => 'welcome', :action => 'index', :month => event.date.strftime("%B")

	end

	def remove_from_month
		user = User.find_by_id(params[:userId]) || current_user
		event = Event.find_by_id(params[:event_id])
		
		if event.users.include?(user)
			event.users.delete(user)
			event.users.each do |tempUser|
				if tempUser.role == "leader"
					UserMailer.usersNotComingAlertMail(tempUser, user).deliver_now
				end
			end
			
		end

		redirect_to :controller => 'welcome', :action => 'index', :month => event.date.strftime("%B")
	end


end
