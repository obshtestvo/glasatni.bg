if @voter_id.present?
  voter = User.find(@voter_id)
  votings = Voting.where(user: voter, votable: @comments).pluck(:votable_id, :value)
else
  votings = []
end

ids = votings.to_h.keys
values = votings.to_h.values

json.comments @comments do |c|
  json.id c.id
  json.content c.content
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

  json.comments c.comments.order(:created_at) do |nc|

    json.id nc.id
    json.content nc.content
    json.time_ago pretty_date(nc.created_at)
    json.hotness nc.hotness
    json.user do
      json.id nc.user.id
      json.name nc.user.name
      json.comments_rank nc.user.comments_rank
      json.proposals_rank nc.user.proposals_rank
      json.moderator nc.user.moderator?
    end

    # TODO 'voted'

  end
end

json.comments_count @comments_count
json.pages_count (@comments_count.to_f/Proposal.default_per_page).ceil
json.page @page

