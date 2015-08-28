class SignupController < ApplicationController
  def index
  	@user = User.new
  	@user.first_name = "Wilhelm"
  end
end
