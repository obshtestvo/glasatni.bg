ActiveAdmin.register User do

  index do
    column(:name) { |u| link_to u.name, user_path(u) }
    actions
  end

end


