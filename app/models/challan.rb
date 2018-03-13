class Challan < ApplicationRecord
  belongs_to :challantype
  belongs_to :trafficpolice
  belongs_to :citizen
  belongs_to :vehicle
end
