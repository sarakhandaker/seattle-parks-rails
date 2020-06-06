class ParkSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :area, :address, :show_features, :show_visits

  def show_features
    self.object.park_features.map do |p_f|
      {hours: p_f.hours,
      feature: p_f.feature.name
      }
    end
  end

  def show_visits
    self.object.visits.map do |v|
      {comment: v.comment,
      date: v.date,
      username: v.user.username,
      rating: v.rating
      }
    end
  end
end
