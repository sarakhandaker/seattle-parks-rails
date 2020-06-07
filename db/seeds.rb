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
    Park.create(name: park[:name], seedAddress: park[:address], latitude: park[:y], longitude: park[:x], area: park[:area])
    sleep 1
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

["Rainier Beach", "Central Business District", "South Lake Union", "West Edge", "Eastlake", "Admiral", 
"Columbia City", "View Ridge", "Morgan Junction", "Cedar Park", "South Park", "Portage Bay", "Licton Springs", 
"Wedgwood", "Montlake", "Seward Park", "Kenwood", "Westlake", "Lakeridge", "Sand Point"]

["University District", "Rainier Beach", "Central Business District", "South Lake Union", "West Edge", "Eastlake", "Admiral", "Beacon Hill", "Ballard", "Leschi", "Mount Baker", "Columbia City", "Broadview", "View Ridge", "Morgan Junction", "Phinney Ridge", "Cedar Park", "South Park", "Portage Bay", "Queen Anne", "Delridge", "Licton Springs", "Wedgwood", "Madrona", "Denny-Blaine", "Central District", "Montlake", "Belltown", "Seward Park", "Fremont", "Green Lake", "Madison Valley", "Madison Park", "Kenwood", "Westlake", "Lakeridge", "Magnolia", "Sand Point", "Maple Leaf", "Capitol Hill", "Wallingford", "Washington Park", "Haller Lake", "Northgate", "Greenwood"] 








["University District", "Rainier Beach", "Central Business District", "South Lake Union", "West Edge", "Eastlake", "Admiral", nil, "Rainier Beach", "Beacon Hill", "Ballard", "South Lake Union", nil, nil, nil, "Leschi", nil, nil, "Central Business District", "Central Business District", "Mount Baker", "Columbia City", "Broadview", "View Ridge", nil, "Central Business District", "Admiral", "Morgan Junction", nil, nil, nil, "Phinney Ridge", "South Lake Union", "Cedar Park", "South Park", nil, "Beacon Hill", "Beacon Hill", "Rainier Beach", "Portage Bay", "West Edge", nil, "Queen Anne", "Mount Baker", "Admiral", "Mount Baker", "Beacon Hill", "Columbia City", nil, nil, nil, "Delridge", "South Lake Union", "University District", "Licton Springs", nil, nil, nil, "Wedgwood", "Admiral", "Queen Anne", "Leschi", "Columbia City", nil, "Madrona", "Denny-Blaine", "South Lake Union", nil, "Admiral", "Central District", nil, "South Park", "Morgan Junction", "Montlake", "Leschi", "Admiral", "Belltown", nil, "Central Business District", "Seward Park", "Columbia City", nil, "Morgan Junction", nil, nil, nil, "South Park", "Portage Bay", "Central Business District", "Central District", "Eastlake", "Columbia City", "Beacon Hill", "Denny-Blaine", nil, "Rainier Beach", "South Lake Union", "South Lake Union", "Eastlake", nil, "South Lake Union", "South Lake Union", nil, nil, nil, nil, nil, nil, "Morgan Junction", "Eastlake", "South Lake Union", nil, nil, "Morgan Junction", "Seward Park", "Central District", "Central Business District", "Rainier Beach", "Leschi", "Central Business District", "Fremont", "Phinney Ridge", "Leschi", "Green Lake", "Central District", "Eastlake", "Columbia City", nil, nil, "Phinney Ridge", nil, "Eastlake", "Licton Springs", "Licton Springs", "Phinney Ridge", "Delridge", "Admiral", "Central Business District", "Madrona", "Eastlake", nil, "Admiral", "South Lake Union", nil, "South Lake Union", "West Edge", "Columbia City", "Madison Valley", "Central Business District", "Columbia City", "Madrona", "Licton Springs", "Columbia City", "Rainier Beach", "Madison Park", "Eastlake", nil, nil, "Montlake", "West Edge", "Wedgwood", "Kenwood", "Madison Valley", nil, "Columbia City", "Beacon Hill", "Columbia City", "Central District", "Central District", "Morgan Junction", nil, "South Lake Union", nil, nil, "Wedgwood", nil, "Phinney Ridge", nil, "Central District", "South Lake Union", "Eastlake", "Rainier Beach", "South Lake Union", "South Lake Union", nil, nil, nil, "South Lake Union", "South Lake Union", "West Edge", "View Ridge", "Cedar Park", "Portage Bay", nil, nil, "Belltown", "Queen Anne", "Delridge", "Morgan Junction", "South Park", nil, nil, "West Edge", "Rainier Beach", "Cedar Park", "Cedar Park", "Columbia City", "Westlake", "Lakeridge", "Rainier Beach", "Denny-Blaine", "Eastlake", "Seward Park", "Seward Park", "Columbia City", "Madison Park", "Columbia City", nil, nil, "Wedgwood", nil, "Leschi", "Leschi", "Beacon Hill", "Kenwood", "Licton Springs", "Morgan Junction", "Licton Springs", nil, nil, nil, "Montlake", "Morgan Junction", nil, "Portage Bay", "South Lake Union", "Madison Park", "Madison Park", "Madrona", "Madrona", "Madrona", "Madrona", nil, "Magnolia", nil, nil, nil, "Sand Point", "Licton Springs", "Maple Leaf", nil, nil, "South Park", "Queen Anne", "Seward Park", "Mount Baker", "Ballard", "Sand Point", "Fremont", "Beacon Hill", "Denny-Blaine", "Capitol Hill", "Central Business District", "Wedgwood", nil, nil, "Wallingford", "Montlake", "Madison Valley", "Licton Springs", "Wedgwood", "Montlake", "Portage Bay", "Morgan Junction", "Mount Baker", "Mount Baker", nil, nil, "Wedgwood", "Madrona", "Kenwood", "Eastlake", "Eastlake", "Wallingford", "Eastlake", "Morgan Junction", "South Lake Union", "Sand Point", "Washington Park", "Washington Park", "West Edge", "Belltown", "Eastlake", nil, nil, "Wedgwood", nil, "Fremont", "Montlake", "Mount Baker", "South Lake Union", "Morgan Junction", "Admiral", "Wedgwood", nil, "Madrona", nil, "Portage Bay", "Haller Lake", "South Lake Union", "Licton Springs", "Portage Bay", nil, "South Lake Union", "West Edge", "South Lake Union", nil, "Morgan Junction", "Rainier Beach", "South Park", nil, nil, "Queen Anne", "Portage Bay", "Morgan Junction", "Leschi", "Belltown", nil, "Northgate", "Kenwood", "West Edge", "Broadview", "Madison Valley", "Central Business District", "Madrona", "Central District", "West Edge", "Madison Valley", "Rainier Beach", "Delridge", "Delridge", "Delridge", "Delridge", "Queen Anne", "Green Lake", "Rainier Beach", "Phinney Ridge", "Columbia City", nil, nil, nil, "Montlake", "Wedgwood", "Central Business District", nil, "Portage Bay", "Eastlake", "Eastlake", "Phinney Ridge", "Morgan Junction", nil, "Wedgwood", "Ballard", "Leschi", "Greenwood", "Admiral", nil, "Beacon Hill", "Central District", "Ballard", "Madison Valley", nil, nil, "Eastlake", "Seward Park", "Kenwood", "Admiral", "Admiral", "Admiral", "Madrona", "Mount Baker", nil, nil, nil, "Rainier Beach", "Beacon Hill", "Fremont", "Portage Bay", nil, nil, "Ballard", nil, "Licton Springs", nil, nil, "South Lake Union", nil, nil, "Licton Springs", "Westlake", "Central Business District", "Central Business District", "Madrona", "Capitol Hill", "Queen Anne", nil, "Phinney Ridge", "Phinney Ridge", "Central Business District", "Columbia City", "Columbia City"] 