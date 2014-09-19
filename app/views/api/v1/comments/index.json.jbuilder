votings = Voting.where(votable: @comments, user: current_user).pluck("votable_id", "value")

ids = votings.to_h.keys
values = votings.to_h.values

json.array! @comments do |c|
  json.id c.id
  json.content c.content
  json.created_at c.created_at
  json.updated_at c.updated_at
  json.proposal_id c.proposal_id
  json.username c.user.name
  json.moderator c.user.role === 1
  json.user_profile_url url_for(c.user)
  json.hotness c.hotness

  idx = ids.index(c.id)

  unless idx.nil?
    json.voted values[idx]
  end

end
