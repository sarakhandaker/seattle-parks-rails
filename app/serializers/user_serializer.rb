class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :bio, :address, :email
end
