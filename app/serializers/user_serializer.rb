class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :address, :email, :show_visits
  def show_visits
    self.object.visits.map do |v|
      {comment: v.comment,
      date: v.date,
      username: v.user.username,
      rating: v.rating,
      park: v.park.name
      }
    end
  end
end
