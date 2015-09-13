class User < ActiveRecord::Base

  has_and_belongs_to_many :events

  def new_token!
  	SecureRandom.hex(16).tap do |random_token|
    	update_attributes token: random_token
  		Rails.logger.info("Set new token for user #{ id }")
  	end
  end
end
