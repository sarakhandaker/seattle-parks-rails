class Park < ApplicationRecord
    has_many :users, through: :saved_parks
    has_many :saved_parks
end
