class WelcomeController < ApplicationController

	def index
		@monthToShowString = params[:month]
		puts params
		user = @current_user || User.find_by(token: cookies[:token])
		if user != nil
			if !user_signed_in? then
				sign_in user
			end
			@monthToShowString = params[:month] || Date::MONTHNAMES[Time.now.month]
				monthInt = Date::MONTHNAMES.index(@monthToShowString)
				@currentYear = (params[:year] || Time.now.year).to_i
				@events = Event.eventsForMonth(monthInt, @currentYear)
				@prevMonth = Date::MONTHNAMES[(monthInt - 1)%13] || "December"
				@nextMonth = Date::MONTHNAMES[(monthInt + 1)%13] || "January"
				@prevMonthYear = (monthInt == 1 ? (@currentYear - 1).to_s : @currentYear).to_s
				@nextMonthYear = (monthInt == 12 ? (@currentYear + 1).to_s : @currentYear).to_s

				 
		else
			redirect_to :controller => 'signup', :action => 'index'
		end
	end

	def sign_up_month
		user = User.find_by(token: params[:token])
		@event 
    	if !user.nil? 
      		sign_in user
			@event = Event.find_by_id(params[:event_id])
			@event.users << user
			redirect_to :controller => 'welcome', :action => 'index', :month => @event.date.strftime("%B"), :year => params[:year]
		else
			redirect_to :controller => 'signup', :action => 'index'

    	end
		


	end

	def remove_from_month
		user = User.find_by(token: params[:token])
		@event 
    	if !user.nil?
      		sign_in user
			@event = Event.find_by_id(params[:event_id])
			@event.users << user

			if @event.users.include?(user)
				@event.users.delete(user)
				@event.users.each do |tempUser|
					if tempUser.role == "leader"
						UserMailer.usersNotComingAlertMail(tempUser, user, @event).deliver_now
					end
				end
			
			end
			redirect_to :controller => 'welcome', :action => 'index', :month => @event.date.strftime("%B"), :year => params[:year]
		else
			redirect_to :controller => 'signup', :action => 'index'
    	end
	end

	def get_more_volunteers
		nextEvent = Event.where("date > ?", Date.today)[0]
		usersToEmail = User.all() - nextEvent.users
		usersToEmail.each do |user|
			UserMailer.needVolunteersEmail(user, nextEvent).deliver_now
		end
	end

end
