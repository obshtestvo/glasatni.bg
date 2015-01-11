json.notifications @notifications do |n|

  json.author do
    json.id n.user.id
    json.name n.user.name
  end
  json.proposal do
    json.id n.proposal.id
    json.title n.proposal.title
  end
  json.action n.action
  json.time_ago pretty_date(n.created_at)

end

json.notifications_count @notifications_count
json.pages_count (@notifications_count.to_f/Notification.default_per_page).ceil
json.page @page