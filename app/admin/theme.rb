ActiveAdmin.register Theme do
  permit_params :name, :info, :user_id

  index do
    column :name
    column :info
    actions
  end

end

