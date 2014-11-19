json.array! @themes do |t|
  json.id t.id
  json.name t.name
  json.info t.info
  json.en_name Theme.en_names.key(t.name)
  json.image_url asset_path("#{Theme.en_names.key(t.name)}.jpg")
end


