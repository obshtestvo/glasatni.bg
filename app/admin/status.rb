ActiveAdmin.register Status do
  permit_params :kind, :notes, :proposal_id

  config.per_page = 20

  index do
    column(:kind)
    column(:notes)
    column(:proposal_id) { |p_id| link_to Proposal.find(p_id).title, admin_proposal_path(p_id) }
    actions
  end

  form do |f|
    f.inputs "Промени статус" do
      f.input :kind, as: :select, collection: Status.kinds.keys
      f.input :notes
      f.input :proposal_id
    end
    f.actions
  end

end

