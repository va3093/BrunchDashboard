require "pry"
class WelcomeController < ApplicationController
	
	def self.max_number_of_volunteers
		return Rails.application.config.max_number_of_volunteers
	end

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
				update_event_states(@events)
				@prevMonth = Date::MONTHNAMES[(monthInt - 1)%13] || "December"
				@nextMonth = Date::MONTHNAMES[(monthInt + 1)%13] || "January"
				@prevMonthYear = (monthInt == 1 ? (@currentYear - 1).to_s : @currentYear).to_s
				@nextMonthYear = (monthInt == 12 ? (@currentYear + 1).to_s : @currentYear).to_s
				analytics.track_event('Viewed month', user, {'Event date'=> @monthToShowString})
				 
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
			update_event_states([@event])
			if @event.status == "full" then
				analytics.track_event('Attempted to sign up for full week', user) 
    			redirect_to :controller => 'general_message', :action => 'message', :message => 'Hmmm. It seems the month you are trying to sign up to has fulled up. Tap the "Continue" button to go to the home page and try another date'
    		else
				if !@event.users.include? user then
					@event.users << user
					analytics.track_event('Signed up to Event', user, {'Event date'=> @event.date.strftime("%d %b")})
				end
				@event.save
				redirect_to :controller => 'welcome', :action => 'index', :month => @event.date.strftime("%B"), :year => params[:year]
    		end 
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
				analytics.track_event('Removed from Event', user, {'Event date'=> @event.date.strftime("%d %b")})
				@event.users.each do |tempUser|
					if tempUser.role == "leader"
						UserMailer.usersNotComingAlertMail(tempUser, user, @event).deliver_now
					end
				end
			
			end
			update_event_states([@event])
			redirect_to :controller => 'welcome', :action => 'index', :month => @event.date.strftime("%B"), :year => params[:year]
		else
			redirect_to :controller => 'signup', :action => 'index'
    	end
	end

	def get_more_volunteers
		user = User.find_by(token: params[:token])
		if !user.nil? && user.role == "leader" then
			nextEvent = Event.find(params[:event_id])
			usersToEmail = User.all() - nextEvent.users
			usersToEmail.each do |user|
				UserMailer.needVolunteersEmail(user, nextEvent).deliver_now
			end

		else
			redirect_to :controller => 'general_message', :action => 'message', :message => 'There seems to have been a problem authenticating your account. Please contact the maintainer of this site for assistance. Tap continue to go to the home screen'
		end
		
	end

	def update_event_states(events)
		events.each do |event|
			if event.status != 'cancelled' then
				if event.users.count >= WelcomeController.max_number_of_volunteers() then
					event.status = "full"
				else
					event.status = "open"
					
				end
			end
			event.save
		end
	end

end
