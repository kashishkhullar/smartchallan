class Admin < ApplicationRecord
	acts_as_token_authenticatable
	has_many :trafficpolices
	# has_one :admin_key
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
