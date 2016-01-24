require 'pry'
class GeneralMessageController < ApplicationController
  def message
  	@message = params[:message]
  	@redirect_controller = params[:redirect_controller] || "welcome"
  	@redirect_action = params[:redirect_action] || "index"
  	@redirect_params = params[:redirect_params] || {}
  	@redirect_button_text = params[:redirect_button_text] || "Continue"

  end
end
