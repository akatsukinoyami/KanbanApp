module TasksHelper
  def filter_name priority
    priority + "_priority_filter"
  end

  def checked priority
    @priorities[:checked].include? priority
  end
end
