ActiveAdmin.register Flag do

  controller do
    def scoped_collection
      Flag.includes(:flaggable).includes(:user)
    end
  end

  index do
    column(:flaggable_type)
    column(:user)
    column(:offender) { |f| link_to f.flaggable.user.name, admin_user_path(f.flaggable.user) }
    column(:flaggable) { |f|
      if f.flaggable_type == "Comment"
        link_to f.flaggable.content, admin_proposal_comment_path(f)
      else
        link_to f.flaggable.title, admin_proposal_path(f)
      end
    }
  end

end


