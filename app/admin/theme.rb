ActiveAdmin.register Theme do
  permit_params :name, :info, :long_info, :user_id, :archived

  index do
    column :name
    column :info
    column :archived
    actions
  end

end

