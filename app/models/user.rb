class User < ActiveRecord::Base
  has_many :orders
  has_many :robots
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:timeoutable, :validatable ,:timeout_in => 10.minutes
end
