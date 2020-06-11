class Visit < ApplicationRecord
    belongs_to :park
    belongs_to :user

    validates :comment, length: { in: 1..500 }, if: ->{ self.completed}
    validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}, if: ->{ self.completed}
    validates :rating, presence: true, if: ->{ self.completed}
    validates :date, presence: true

    validates :user, :uniqueness => {:scope => [:date, :park], 
    message: ->(object, data) do
        "the visit to this park on this date has already been saved."
      end}
end
