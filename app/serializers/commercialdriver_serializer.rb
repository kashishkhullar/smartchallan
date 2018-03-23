class CommercialdriverSerializer < ActiveModel::Serializer
  attributes :id,:start_date,:end_date
  has_one :commercial
  has_one :citizen
  has_one :vehicle
end
