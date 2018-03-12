class Challan < ApplicationRecord
  belongs_to :challan_type
  belongs_to :traffic_police
  belongs_to :citizen
end
