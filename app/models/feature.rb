class Feature < ApplicationRecord
    has_many :park_features
    has_many :parks, through: :park_features
end
