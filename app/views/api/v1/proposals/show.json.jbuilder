json.id @proposal.id
json.title @proposal.title
json.content @proposal.content
json.theme_id @proposal.theme_id
json.theme_name @proposal.theme.name
json.comments_count @proposal.comments_count
json.hotness @proposal.hotness
json.user_id @proposal.user.id
json.username @proposal.user.name

voted = Voting.where(votable_id: @proposal.id, user: current_user).first
json.voted voted.value unless voted.nil?

json.moderator @proposal.user.role === 1
json.user_profile_url url_for(@proposal.user)
json.created_at @proposal.created_at
json.updated_at @proposal.updated_at
