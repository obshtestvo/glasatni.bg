json.array! @proposals do |p|
  json.id p.id
  json.theme_id p.theme_id
  json.user_id p.user_id
  json.title p.title
  json.content p.content
  json.up p.up
  json.down p.down
  json.hotness p.hotness
  json.created_at p.created_at
  json.updated_at p.updated_at
end