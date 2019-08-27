require 'date'

class Objective
  attr_reader :id, :start, :target, :start_date, :end_date, :milestones

  def initialize(id, start, target, start_date, end_date, milestones)
    @id = id
    @start = start
    @target = target
    @start_date = Date.strptime(start_date, '%Y-%m-%d')
    @end_date = Date.strptime(end_date, '%Y-%m-%d')
    @milestones = milestones.sort_by { |m| m.date.mjd }
  end

  def calculate_number_of_days
    end_date.mjd - start_date.mjd
  end
end