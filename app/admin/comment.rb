ActiveAdmin.register Comment, :as => "ProposalComment" do

  index do
    selectable_column
    column :content
    actions
  end

end
