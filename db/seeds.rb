# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
Park.destroy_all
Feature.destroy_all
ParkFeature.destroy_all

require 'csv'

array1=CSV.read("./data/Seattle_Parks.csv")
##array of arrays #each inner array [id, name, area, length, shapearea]

array2=CSV.read("./data/Seattle_Parks_and_Recreation_Parks_With_Features.csv")
##array of arrays #each inner array [pmaid, name, feature_desc, hours, xpos, ypos, Location]

array3=CSV.read("./data/Seattle_Parks_And_Recreation_Park_Addresses.csv")
##array of arrays #each inner array [PMAID,LocID,Name,Address,ZIP Code,X Coord,Y Coord,Location 1]

## FROM ARRAY 1
all_parks=[]

array1.each {|park| all_parks<<{name: park[1], area: park[5]}}
all_parks.shift
all_parks= all_parks.select{|park| park[:name] != nil}

## FROM ARRAY 3
all_parks2=[]
parknames=[]

array3.each do |park| 
    all_parks2<<{name: park[2].upcase, address: park[3], x: park[5], y:park[6]} if !parknames.include?(park[2].upcase)
    parknames<< park[2].upcase
end

all_parks2.shift

all_parks.each do |park1|
    all_parks2.each do |park2|
        if park1[:name]==park2[:name]
            park2[:area]=park1[:area]
        end
    end
    # if !parknames.include?(park1[:name])
    #     all_parks2<< park1
    #     parknames<< park1[:name]
    # end
end

all_parks2.each { |park|
    Park.create(name: park[:name], address: park[:address], latitude: park[:y], longitude: park[:x], area: park[:area])
}

## FROM ARRAY 2

features=["Golf",
 "Play Area (ADA Compliant)",
 "Basketball (Full)",
 "Bike Trail",
 "Play Area",
 "Paths",
 "Waterfront",
 "P-Patch Community Garden",
 "Soccer",
 "View",
 "Woods",
 "Historic Landmark",
 "Creek",
 "Garden",
 "Boat Launch (Hand Carry)",
 "Adult Fitness Equipment",
 "Guarded Beach",
 "Restrooms (ADA Compliant)",
 "Wading Pool or Water Feature",
 "Tennis Lights",
 "Picnic Sites",
 "Disc Golf",
 "Restrooms",
 "Weddings and Ceremonies",
 "Green Space",
 "Paths (ADA Compliant)",
 "Baseball/Softball",
 "Fishing",
 "Basketball (Half)",
 "Rental Facility",
 "Hiking Trails",
 "Pesticide Free",
 "Decorative Fountain",
 "Tennis Court (Outdoor)",
 "Horseshoe Pits",
 "Dog Off Leash Area",
 "Skatepark",
 "Football",
 "Marination Ma Kai",
 "Lawn Bowling",
 "Tennis Backboard (Outdoor)",
 "Scuba Diving",
 "Community Building",
 "Environmental Learning Center",
 "NO Beach Access",
 "Fire Pit",
 "Pool (Outdoor)",
 "Lacrosse",
 "Boat Moorage",
 "Picnic Sites (ADA Compliant)",
 "Skatespot",
 "Model Boat Pond",
 "Community Center",
 "Cricket",
 "Ultimate",
 "Track",
 "Rugby",
 "Boat Launch (Motorized)",
 "Bike Polo",
 "Pool (Indoor)",
 "T-Ball",
 "Pickleball Court",
 "Flag Football"]

 features.each { |feat|
    Feature.create(name: feat)
}

array2.each do |row|
##array of arrays #each inner array [pmaid, name, feature_desc, hours, xpos, ypos, Location]
if Park.find_by(name: row[1].upcase) && Feature.find_by(name: row[2])
    park=Park.find_by(name: row[1].upcase)
    feature=Feature.find_by(name: row[2])
    ParkFeature.create(park_id: park.id, feature_id: feature.id, hours: row[3])
end

end