class AdminSerializer < ActiveModel::Serializer
  attributes :id,:email,:mobile,:authentication_token
end