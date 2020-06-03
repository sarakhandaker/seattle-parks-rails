class User < ApplicationRecord
    has_many :parks, through: :saved_parks
    has_many :saved_parks
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :email, uniqueness: { case_sensitive: false }
end
