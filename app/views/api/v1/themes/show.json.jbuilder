json.name @theme.name
json.en_name Theme.en_names.key(@theme.name)
json.info @theme.info
json.image_url asset_path("#{Theme.en_names.key(@theme.name)}.jpg")

json.moderator do
  json.id @theme.user.id unless @theme.user.nil?
  json.name @theme.user.name unless @theme.user.nil?
end
