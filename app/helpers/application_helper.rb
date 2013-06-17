module ApplicationHelper
  def action_classes
    %W[#{controller_name}_controller #{action_name}_action]
  end
end
