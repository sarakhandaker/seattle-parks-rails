class Park < ApplicationRecord
    has_many :saved_parks
    has_many :users, through: :saved_parks
    has_many :park_features
    has_many :features, through: :park_features
    has_many :visits
    has_many :users, through: :visits

    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode

    def neighborhood 
        results = Geocoder.search([self.latitude, self.longitude]).first
        if results.neighbourhood
            return results.neighbourhood
        elsif results.suburb
            return results.suburb
        end
    end

    def self.list_by_distance(user)
        self.all.sort_by{|store| store.distance_to(user) }
    end
end
