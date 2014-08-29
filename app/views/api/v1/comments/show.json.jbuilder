json.id @comment.id
json.content @comment.content
json.created_at @comment.created_at
json.updated_at @comment.updated_at
json.proposal_id @comment.proposal_id
json.username @comment.user.name
json.user_profile_url url_for(@comment.user)
json.rating @comment.rating
