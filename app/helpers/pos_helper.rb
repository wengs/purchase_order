module PosHelper
  def client_milestone_flag_color(milestone)
    case milestone
    when :information_required
      'danger'
    when :files_needed
      'warning'
    else
      'default'
    end
  end

  def io_user_milestone_flag_color(milestone)
    case milestone
    when :information_required
      'danger'
    when :files_needed
      'warning'
    when :graphic_amended
      'info'
    when :ready_for_quote
      'success'
    else
      'default'
    end
  end

  def milestone_flag_color(milestone)
    current_user.client? ? client_milestone_flag_color(milestone) : io_user_milestone_flag_color(milestone)
  end
end
