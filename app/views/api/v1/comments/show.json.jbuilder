json.id @comment.id
json.content @comment.content
json.created_at @comment.created_at
json.updated_at @comment.updated_at
json.commentable_id @comment.commentable_id
json.username @comment.user.name
json.moderator @comment.user.role === 1
json.user_profile_url url_for(@comment.user)
json.hotness @comment.hotness
