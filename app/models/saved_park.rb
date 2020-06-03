class SavedPark < ApplicationRecord
    belongs_to :user
    belongs_to :park
end
