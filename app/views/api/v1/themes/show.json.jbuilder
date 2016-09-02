json.name @theme.name
json.en_name Theme.en_names.key(@theme.name)
json.info @theme.info
json.long_info @theme.long_info
json.image_url asset_path("#{Theme.en_names.key(@theme.name)}.jpg")
json.archived @theme.archived?

json.moderator do
  json.id @theme.moderator.id unless @theme.moderator.nil?
  json.name @theme.moderator.name unless @theme.moderator.nil?
end
