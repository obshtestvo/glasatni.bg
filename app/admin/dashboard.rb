ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "Последни коментари" do
          table_for Comment.order('created_at desc').limit(10) do
            column("content")   { |comment| comment.content }
          end
        end
      end

      column do
        panel "Последни предложения" do
          table_for Proposal.order('created_at desc').limit(10).each do |proposal|
            column(:title)    { |proposal| proposal.title }
          end
        end
      end

    end

  end
end
