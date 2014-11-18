json.id @comment.id
json.content @comment.content
json.comments_count @comment.comments_count
json.created_at @comment.created_at
json.time_ago pretty_date(@comment.created_at)
json.updated_at @comment.updated_at
json.commentable_id @comment.commentable_id
json.user do
  json.id @comment.user.id
  json.name @comment.user.name
  json.comments_rank @comment.user.comments_rank
  json.proposals_rank @comment.user.proposals_rank
  json.moderator @comment.user.moderator?
end
json.moderator @comment.user.moderator?
json.hotness @comment.hotness
