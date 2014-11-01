json.id @user.id
json.name @user.name
json.bio @user.bio
json.time_ago pretty_date @user.created_at
json.avatar_url @user.avatar.url(:thumb)
json.comments_rank translate_rank @user.comments_rank
json.proposals_rank translate_rank @user.proposals_rank
