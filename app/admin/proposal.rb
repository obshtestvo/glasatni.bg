ActiveAdmin.register Proposal do
  permit_params :title, :content

  index do
    column :title
    column :content
    actions
  end

end
