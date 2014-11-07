json.id @proposal.id
json.type "proposal"
json.title @proposal.title
json.content @proposal.content

json.theme do
  json.id @proposal.theme.id
  json.name @proposal.theme.name
end

json.comments_count @proposal.comments_count
json.hotness @proposal.hotness
json.user @proposal.user, :id, :name, :comments_rank, :proposals_rank
voted = Voting.where(votable_id: @proposal.id, user: current_user).first
json.voted voted.value unless voted.nil?

json.moderator @proposal.user.role === 1
json.user_profile_url url_for(@proposal.user)
json.created_at @proposal.created_at
json.updated_at @proposal.updated_at
