class Challan < ApplicationRecord
  belongs_to :challan_type
  belongs_to :trafficpolice
  belongs_to :citizen
end
