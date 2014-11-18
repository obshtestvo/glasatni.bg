ActiveAdmin.register User, as: "Subscriber" do

  controller do
    def scoped_collection
      User.subscribed
    end
  end

  index do
    column(:name) { |u| link_to u.name, admin_user_path(u) }
    column(:email)
    actions
  end

  csv do
    column :name
    column :email
  end

end


