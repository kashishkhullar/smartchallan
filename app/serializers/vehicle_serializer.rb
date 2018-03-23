class VehicleSerializer < ActiveModel::Serializer
  attributes :id,:name,:category,:dop,:registration_no,:citizen_id,:commercial_id
  has_one :citizen
  has_many :challans
  has_one :pollution

end
