class Commercialdriver < ApplicationRecord
  belongs_to :commercial
  belongs_to :citizen
  belongs_to :vehicle
end
