class Pollution < ApplicationRecord
  belongs_to :vehicle
  belongs_to :citizen
end
