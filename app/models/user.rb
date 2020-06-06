require 'geocoder'

class User < ApplicationRecord
    include ActiveModel::Validations
    geocoded_by :address
    after_validation :geocode

    has_many :parks, through: :saved_parks
    has_many :saved_parks

    has_many :visits
    has_many :parks, through: :visits

    has_secure_password

    validates :username, presence: true
    validates :username, uniqueness: { case_sensitive: false }
    validates :email, uniqueness: { case_sensitive: false }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :email, presence: true
    validates :address, presence: true
    validates :password, length: { in: 6..20 } , on: :create
    validates_with AddressValidator

    #   def ordered_visits
    #     self.visits.sort_by{|visit| visit.date}.reverse
    #   end

end
  
