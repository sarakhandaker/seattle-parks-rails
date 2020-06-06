require 'geocoder'
class AddressValidator < ActiveModel::Validator
    def validate(record)
        location = Geocoder.search(record.address)
        if location.empty?
            record.errors[:address] << "Please enter a valid address"
          end
    end
end