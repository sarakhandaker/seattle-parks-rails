class Visit < ApplicationRecord
    belongs_to :park
    belongs_to :user

    validates :comment, length: { in: 1..500 }
    validates :rating, length: { in: 0..5 }
    validates :rating, presence: true
    validates :date, presence: true
end
