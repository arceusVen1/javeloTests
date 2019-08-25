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
    n_days = @objective.calculate_number_of_days
    return 100 if n_days.zero?

    should_be_percentage = ((@date.mjd - @objective.start_date.mjd) / n_days.to_f) * 100
    current_percentage = calculate_work_percentage
    (((current_percentage - should_be_percentage) / should_be_percentage.to_f) * 100).round
  end
end