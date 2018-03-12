class Vehicle < ApplicationRecord
  belongs_to :citizen
  has_one :pollution
  #has_many :challans
end
