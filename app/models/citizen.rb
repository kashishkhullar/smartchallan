class Citizen < ApplicationRecord
	has_many :challans
	has_many :vehicles
	has_many :pollutions
	acts_as_token_authenticatable
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
