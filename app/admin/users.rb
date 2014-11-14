ActiveAdmin.register User do
  permit_params :name, :role, :bio

  config.per_page = 20

  index do
    column(:name) { |u| link_to u.name, admin_user_path(u) }
    column(:role)
    actions
  end

  form do |f|
    f.inputs "Edit My Model" do
      f.input :role, as: :select, collection: User.roles.keys
      f.input :bio
    end
    f.actions
  end

end

