class CommercialSerializer < ActiveModel::Serializer
  attributes :id,:email,:mobile,:phone_no,:company_name,:owner_name,:identification_no,:address
  has_many :vehicles
  has_many :citizens
  has_many :commercialdrivers
end
