votings = Voting.where(votable: @comments, user: current_user).pluck("votable_id", "value")

ids = votings.to_h.keys
values = votings.to_h.values

json.comments @comments do |c|
  json.id c.id
  json.content c.content
  json.created_at c.created_at
  json.time_ago pretty_date(c.created_at)
  json.updated_at c.updated_at
  json.commentable c.commentable.id
  json.comments_count c.comments_count
  json.user c.user, :id, :name, :role
  json.moderator c.user.role === 1
  json.user_profile_url url_for(c.user)
  json.hotness c.hotness

  idx = ids.index(c.id)

  unless idx.nil?
    json.voted values[idx]
  end

end

json.comments_count @beforePaged.count
json.page @page
