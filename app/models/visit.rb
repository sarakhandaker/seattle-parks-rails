class Visit < ApplicationRecord
    belongs_to :park
    belongs_to :user

    validates :comment, length: { in: 1..500 }
    validates :rating, length: { in: 0..5 }
    validates :rating, presence: true
    validates :date, presence: true

    validates :user, :uniqueness => {:scope => [:date, :park], 
    message: ->(object, data) do
        "the visit to this park on this date has already been saved."
      end}
end
