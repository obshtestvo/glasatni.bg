json.array!(@proposals) do |proposal|
  json.extract! proposal, :id, :theme_id, :title, :content, :up, :down
  json.url proposal_url(proposal, format: :json)
end
