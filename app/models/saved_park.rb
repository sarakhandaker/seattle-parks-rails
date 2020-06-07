class SavedPark < ApplicationRecord
    belongs_to :user
    belongs_to :park

    validates_uniqueness_of :user_id, :scope => :park_id
end
