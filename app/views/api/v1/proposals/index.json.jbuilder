json.proposals @proposals do |p|
  json.id p.id

  json.user do
    json.id p.user_id
    json.name p.user.name
  end

  json.title p.title
  json.content p.content

  json.voted @votings[p.id]

  json.theme do
    json.id p.theme_id
    json.name p.theme.name
    unless p.theme.moderator.nil?
      json.moderator do
        json.id p.theme.moderator.id
        json.name p.theme.moderator.name
      end
    end
  end

  json.up p.up
  json.down p.down
  json.hotness p.hotness
  json.comments_count p.comments_count
  json.approved p.approved
  json.created_at p.created_at
  json.time_ago pretty_date(p.created_at)
  json.updated_at p.updated_at
end

json.proposals_count @proposals_count
json.pages_count (@proposals_count.to_f/Proposal.default_per_page).ceil
json.page @page

