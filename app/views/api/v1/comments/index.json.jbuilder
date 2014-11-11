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
  json.user do
    json.id c.user.id
    json.name c.user.name
    json.comments_rank c.user.comments_rank
    json.proposals_rank c.user.proposals_rank
    json.moderator c.user.moderator?
  end
  json.hotness c.hotness

  idx = ids.index(c.id)

  unless idx.nil?
    json.voted values[idx]
  end
end

json.comments_count @comments_count
json.pages_count (@comments_count.to_f/Proposal.default_per_page).ceil
json.page @page

