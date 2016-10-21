class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text,:dist
  has_one :location
  def dist
    lat = instance_options[:lat]
    lng = instance_options[:lng]
    if lat && lng
      return  object.location.distance_to(Location.new(lat: lat,lng: lng))
    else
      return nil
    end
  end
end
