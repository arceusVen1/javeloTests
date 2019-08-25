# frozen_string_literal: true

class ProgressiveRecord
  attr_reader :id, :objective, :value

  def initialize(id, objective, value)
    @id = id
    @objective = objective
    @value = value
  end

  def calculate_work_percentage
    difference = (@objective.target - @objective.start).to_f.abs
    return 100 if difference.zero?

    value = (@value - @objective.start).to_f
    if @objective.target < @objective.start
      value = (@objective.start - @value).to_f
    end
    (value / difference * 100).round
  end
end