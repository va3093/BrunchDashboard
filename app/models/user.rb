class User < ActiveRecord::Base

  has_many :assignments
  has_many :events, through: :assignments

  def new_token!
  	SecureRandom.hex(16).tap do |random_token|
    	update_attributes token: random_token
  		Rails.logger.info("Set new token for user #{ id }")
  	end
  end
end
