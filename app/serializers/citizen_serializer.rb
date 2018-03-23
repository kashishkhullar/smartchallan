class CitizenSerializer < ActiveModel::Serializer
  attributes :id,:email,:first_name,:last_name,:mobile,:dob,:address,:commercial_id
end
