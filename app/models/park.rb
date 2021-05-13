class Park < ApplicationRecord
    has_many :saved_parks
    has_many :users, through: :saved_parks
    has_many :park_features
    has_many :features, through: :park_features
    has_many :visits
    has_many :users, through: :visits

    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode

    self.per_page = 30

    def get_neighborhood 
        results = Geocoder.search([self.latitude, self.longitude]).first
        if results.neighbourhood
            return results.neighbourhood
        elsif results.suburb
            return results.suburb
        end
    end

    def self.list_by_distance(user)
        self.all.sort_by{|park| park.distance_to(user) }
    end

    def self.busiet
        self.all.max_by{|park| park.visits.length}
    end

    def self.best_rated
        self.all.max_by{|park| park.avg_rating}
    end

    def avg_rating
        rated_visits= self.visits.select{|visit| visit.completed}
        if rated_visits.length > 0
        rated_visits.map{|visit| visit.rating}.reduce(0, :+)/rated_visits.length
        else 
            0
        end
    end
    def visit_length
        self.visits.length
    end
end
