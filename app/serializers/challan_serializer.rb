class ChallanSerializer < ActiveModel::Serializer
  attributes :id,:challantype_id,:date_of_issue,:time_of_issue,:latitude,:longitude,:address,:due_date
end
