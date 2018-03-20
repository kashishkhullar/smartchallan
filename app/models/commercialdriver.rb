class Commercialdriver < ApplicationRecord
  belongs_to :commercials
  belongs_to :citizens
  belongs_to :vehicle
end
