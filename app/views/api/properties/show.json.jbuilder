json.extract! @property, *@property.attributes.keys
# json.extract! @zillow, *@zillow.attributes.keys
json.zillow @zillow do |k, v|
  json.k v
end

if current_user
  json.current_user_follow current_user.follows.find_by(property_id: @property.id)
end

json.images do
  json.array! @property.images do |image|
    json.id image.id
    json.image_url image.image_url
    json.property_id image.property_id
    json.thumb_url image.thumb_url
  end
end

json.followers @property.followers, :id, :email
json.investors @property.investors.count
