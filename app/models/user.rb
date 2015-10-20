class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :assignments
  has_many :events, through: :assignments

  validates :first_name, presence: true
  validates :email, presence: true

  def password_required?
    return false
  end

  def new_token!
  	SecureRandom.hex(16).tap do |random_token|
    	update_attributes token: random_token
  		Rails.logger.info("Set new token for user #{ id }")
  	end
  end
end
