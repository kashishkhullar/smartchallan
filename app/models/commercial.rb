class Commercial < ApplicationRecord
	acts_as_token_authenticatable
	has_many :vehicles
	has_many :citizens
	has_many :commercialdrivers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
