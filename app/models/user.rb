require 'csv' 

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments
  has_many :events, through: :assignments

  validates :first_name, presence: true
  validates :email, presence: true
  validates :token, presence: true

  def password_required?
    return false
  end

  def new_token!
  	SecureRandom.hex(16).tap do |random_token|
    	update_attributes token: random_token
  		Rails.logger.info("Set new token for user #{ id }")
  	end
  end

  def self.importFromCSV(path) 
      CSV.foreach(File.join(File.dirname(__FILE__), path)) do |row|
        if User.find_by(email: row[2]).nil? then
          user = User.create({
          :first_name => row[0],
          :last_name => row[1],
          :email => row[2],
          }
        )
      user.new_token!
      user.save()
      puts user
        else
          puts "User already exists"
        end
    end
  end

  def self.sendWelcomeEmailToAllUsers() 
    User.all().each do |user|
      UserMailer.welcomeEmail(user).deliver_now
    end
  end

  def self.sendMonthlyReminderEmailToAllUsers() 
    events =  Event.eventsForMonth(Time.now.month + 1, Time.now.year) 
    User.all().each do |user|
      UserMailer.monthlySignupReminder(user,events).deliver
    end
  end
end
