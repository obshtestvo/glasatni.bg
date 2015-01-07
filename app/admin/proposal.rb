ActiveAdmin.register Proposal do
  permit_params :title, :content, :user_id, :theme_id

  config.per_page = 20

  index do
    column :title
    column :content
    column :up
    column :down
    actions
  end

end
