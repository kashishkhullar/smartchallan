class ChallanSerializer < ActiveModel::Serializer
  attributes :id,:challantype_id,:date_of_issue,:time_of_issue,:latitude,:longitude,:address,:due_date,:paid
  has_one :vehicle
  has_one :challantype
  has_one :citizen
  has_one :trafficpolice
end
