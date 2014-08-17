module ProposalsHelper

  def parse_buttons c, voted_on, type

    classes = "btn btn-default btn-sm vote-button"
    idx = voted_on.index { |v| v[0] == c.id }

    p c.id
    p voted_on

    # classes remains the same
    if idx.nil?

      classes_up, classes_down = classes, classes

    # add classes for up
    elsif voted_on[idx][1] == Voting.values[:up]

      classes_down = classes
      classes_up = classes += " btn-warning"

    # add classes for down
    elsif voted_on[idx][1] == Voting.values[:down]

      classes_up = classes
      classes_down = classes += " btn-warning"

    end

    if type == :comment
      classes += " comment"
      title_msg_up = "Добра аргументация"
      title_msg_down = "Лоша аргументация"
    else
      classes += " proposal"
      title_msg_up = "Добра идея"
      title_msg_down = "Лоша идея"
    end

    fin = button_tag class: classes_up, disabled: !user_signed_in?, id: "#{c.id}-up", "data-placement" => "right", "data-toggle" => "tooltip", title: title_msg_up do
      '<i class="fa fa-arrow-up"></i>'.html_safe
    end
    fin += button_tag class: classes_down, disabled: !user_signed_in?, id: "#{c.id}-down", "data-placement" => "right", "data-toggle" => "tooltip", title: title_msg_down do
     '<i class="fa fa-arrow-down"></i>'.html_safe
    end
    fin
  end

end
