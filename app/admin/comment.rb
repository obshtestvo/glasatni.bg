ActiveAdmin.register Comment, :as => "ProposalComment" do
  permit_params :content

  index do
    selectable_column
    column :content
    actions
  end

end
