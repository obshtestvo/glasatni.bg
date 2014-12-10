json.array! @notifications do |n|

  json.author do
    json.id n.user.id
    json.name n.user.name
  end
  json.proposal do
    json.id n.proposal.id
    json.title n.proposal.title
  end
  json.action n.action

end

