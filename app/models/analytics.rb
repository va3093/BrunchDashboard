class Analytics

  class CustomError < Mixpanel::ErrorHandler
    def handle(error)
      puts error
    end
  end

  def initialize(user)
    @user = user

    @tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_ID'], CustomError.new)
  end


  def track_event(event, user=nil, properties={})
    _user = user || @user
    @tracker.track(_user.id.to_s, event, properties)
  end

  def set_user_properties(user=nil)
    _user = user || @user
    @tracker.people.set(_user.id.to_s, {
      '$first_name'       => _user.first_name,
      '$last_name'        => _user.last_name,
    });
  end
end
