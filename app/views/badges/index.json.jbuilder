json.array!(@badges) do |badge|
  json.extract! badge, :id, :name, :info
  json.url badge_url(badge, format: :json)
end
