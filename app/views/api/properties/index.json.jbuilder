json.array! @properties do |property|
  json.extract! property, *property.attributes.keys
  json.investors property.investors.count
  if current_user
    json.current_user_follow current_user.follows.find_by(property_id: property.id)
    json.current_user_invested current_user.investments.find_by(property_id: property.id)
  end

  json.images do
    json.array! property.images do |image|
      json.id image.id
      json.image_url image.image_url
      json.property_id image.property_id
      json.thumb_url image.thumb_url
    end
  end

  json.zillow_chart property.get_zillow_chart

  json.investments do
    json.initial property.investments.where(initial: true)
    json.pending do
      json.array! property.investments.where(pending: true, initial: false) do |investment|
        json.id investment.id
        json.user_id  investment.user_id
        json.percentage investment.percentage
        json.initial investment.initial
        json.created_at investment.created_at
      end
    end
    json.confirmed do
      json.array! property.investments.where(pending: false) do |investment|
        json.id investment.id
        json.user_id  investment.user_id
        json.percentage investment.percentage
        json.initial investment.initial
        json.created_at investment.created_at
      end
    end
    json.total_confirmed property.investments.where(pending:false).sum(:percentage)
    json.total_pending property.investments.where(pending:true, initial: false).sum(:percentage)
    json.total_overall property.investments.sum(:percentage)
  end
end
