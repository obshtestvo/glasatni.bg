json.users @users do |u|
  json.id u.id
  json.name u.name
  json.reputation u.reputation
  json.comments_rank u.comments_rank
  json.proposals_rank u.proposals_rank
  json.moderator u.moderator?
  json.created_at u.created_at
  json.time_ago pretty_date(u.created_at)
  json.updated_at u.updated_at
end

json.users_count @users_count
json.pages_count (@users_count.to_f/User.default_per_page).ceil
json.page @page


