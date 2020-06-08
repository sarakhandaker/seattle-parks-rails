class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :address, :email, :show_visits, :saved_list :latitude, :longitude
  def show_visits
    self.object.visits.map do |v|
      {comment: v.comment,
      date: v.date,
      username: v.user.username,
      rating: v.rating,
      park: v.park.name,
      id: v.id
      }
    end
  end
  def saved_list
    self.object.saved_parks.map do |s_p|
      {park: s_p.park.name,
      park_id: s_p.park.id,
      id: s_p.id
      }
    end
  end
end
