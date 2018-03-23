class TrafficpoliceSerializer < ActiveModel::Serializer
  attributes :id,:email,:mobile,:dob,:address,:first_name,:last_name
end