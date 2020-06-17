class AllParkSerializer < ActiveModel::Serializer
    attributes :id, :latitude, :longitude, :name, :seedAddress, :features, :neighborhood
  
    def features
      self.object.park_features.map do |p_f|
        {name: p_f.name
        }
      end
    end

  
  end
  