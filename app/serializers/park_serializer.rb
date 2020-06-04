class ParkSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :area
  has_many :features
end
