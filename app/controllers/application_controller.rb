class ApplicationController < ActionController::Base

  def analytics
    @analytics ||= Analytics.new(current_user)
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def test_exception_notifier
    raise 'This is a test. This is only a test.'
  end

  def after_sign_out_path_for(resource_or_scope)
  	cookies.permanent[:token] = ""
    root_path
  end
end
