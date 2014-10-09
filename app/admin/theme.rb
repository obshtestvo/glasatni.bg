ActiveAdmin.register Theme do
  permit_params :name, :info

  index do
    column :name
    column :info
    actions
  end

end

