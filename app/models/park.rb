class Park < ApplicationRecord
    has_many :saved_parks
    has_many :users, through: :saved_parks
    has_many :park_features
    has_many :features, through: :park_features
end
