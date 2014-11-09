json.id @comment.id
json.content @comment.content
json.comments_count @comment.comments_count
json.created_at @comment.created_at
json.updated_at @comment.updated_at
json.commentable_id @comment.commentable_id
json.user @comment.user, :id, :name, :role, :comments_rank, :proposals_rank
json.moderator @comment.user.role === 1
json.hotness @comment.hotness
