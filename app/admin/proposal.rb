ActiveAdmin.register Proposal do
  permit_params :title, :content

  config.per_page = 20

  index do
    column :title
    column :content
    actions
  end

end
