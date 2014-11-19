json.array! @themes do |t|
  json.id t.id
  json.name t.name
  json.info t.info
  json.en_name Theme.en_names.key(t.name)
end


