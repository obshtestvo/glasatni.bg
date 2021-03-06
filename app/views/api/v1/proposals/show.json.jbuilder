json.id @proposal.id
json.type "proposal"
json.title @proposal.title
json.content @proposal.content

json.theme do
  json.id @proposal.theme.id
  json.name @proposal.theme.name
  json.archived @proposal.theme.archived
  json.en_name Theme.en_names.key(@proposal.theme.name)
end

json.comments_count @proposal.comments_count
json.hotness @proposal.hotness
json.user do
  json.id @proposal.user.id
  json.name @proposal.user.name
  json.comments_rank @proposal.user.comments_rank
  json.proposals_rank @proposal.user.proposals_rank
  json.moderator @proposal.user.moderator?
end

json.statuses @proposal.statuses do |s|
  json.kind Status.kinds.key(s.kind)
  json.time_ago pretty_date(s.created_at)
  json.notes s.notes
end

json.approved @proposal.approved
json.time_ago pretty_date(@proposal.created_at)

if @voter_id.present?
  voter = User.find(@voter_id)
  json.voted Voting.where(votable_id: @proposal.id, user: voter).try(:first).try(:value)
end

json.created_at @proposal.created_at
json.updated_at @proposal.updated_at
