ActiveAdmin.register Comment, :as => "ProposalComment" do
  permit_params :content

  config.per_page = 10

  index do
    selectable_column
    column :content
    column :up
    column :down
    actions
  end

end
