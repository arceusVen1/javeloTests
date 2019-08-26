# frozen_string_literal: true

require 'date'

class ProgressiveRecord
  attr_reader :id, :objective, :value, :date

  def initialize(id, objective, value, date)
    @id = id
    @objective = objective
    @value = value
    @date = Date.strptime(date, '%Y-%m-%d')
  end

  def get_milestone_values
    target_date = @objective.end_date
    start_date = @objective.start_date
    start = @objective.start
    (0..@objective.milestones.size - 1).each do |i|
      if @objective.milestones[i].date >= @date && i - 1 >= 0
        # means we are between two milestones
        target_date = @objective.milestones[i].date
        start_date = @objective.milestones[i - 1].date
        start = @objective.milestones[i - 1].target
        break
      elsif @objective.milestones[i].date >= @date
        # means we are before first milestone
        target_date = @objective.milestones[i].date
        break
      elsif i == @objective.milestones.size - 1
        # means we are after last milestone
        start_date = @objective.milestones[i].date
        start = @objective.milestones[i].target
        break
      end
    end
    [target_date, start_date, start]
  end

  def calculate_work_percentage
    difference = (@objective.target - @objective.start).to_f.abs
    return 100 if difference.zero?

    value = (@value - @objective.start).to_f
    if @objective.target < @objective.start
      value = (@objective.start - @value).to_f
    end
    (value / difference * 100)
  end

  def calculate_excess
    milestone_values = get_milestone_values
    n_days = (milestone_values[0].mjd - milestone_values[1].mjd)
    return 100 if n_days.zero?

    factor = 1
    if @objective.target < @objective.start
      factor = -1
    end

    should_be_value = (factor * (@date.mjd - milestone_values[1].mjd) / n_days.to_f + 1) * milestone_values[2]
    should_be_percentage = factor * (should_be_value - @objective.start).to_f / (@objective.target - @objective.start).abs * 100
    current_percentage = calculate_work_percentage
    puts should_be_value
    puts @value
    puts should_be_percentage
    puts current_percentage
    (((current_percentage - should_be_percentage) / should_be_percentage.to_f) * 100).round
  end
end