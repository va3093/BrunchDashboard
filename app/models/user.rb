class User < ActiveRecord::Base
  has_many :assignments
  has_many :events, through: :assignments
end
