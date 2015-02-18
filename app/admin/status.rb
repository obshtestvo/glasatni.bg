ActiveAdmin.register Status do
  permit_params :kind, :notes, :proposal_id

  config.per_page = 20

  index do
    column(:kind) { |s| Status.kinds.key(s.kind) }
    column(:notes)
    column(:proposal)
    actions
  end

  show do
    attributes_table do
      row :kind do |s|
        Status.kinds.key(s.kind)
      end
      row :notes
      row :proposal
    end

  end

  form do |f|
    f.inputs "Промени статус" do
      f.input :kind, as: :select, collection: Status.kinds.to_a
      f.input :notes
      f.input :proposal_id
    end
    f.actions
  end

end

