require 'date'

class Objective
  attr_reader :id, :start, :target, :start_date, :end_date, :parent_id, :weight, :children, :milestones

  def initialize(id, start, target, start_date, end_date, parent_id, weight, children, milestones)
    @id = id
    @start = start
    @children = children
    _compute_target(target)
    _compute_start(start)
    _compute_start_and_end_date(start_date, end_date)
    @parent_id = parent_id
    @weight = weight
    @milestones = milestones.sort_by { |m| m.date.mjd }
  end

  def _compute_start_and_end_date(start_date, end_date)
    if start_date.nil? || end_date.nil?
      children = @children.map { |child| child.end_date.mjd }
      @end_date = Date.jd(@children.map { |child| child.end_date.mjd }.max)
      @start_date = Date.jd(@children.map { |child| child.start_date.mjd }.min)
    else
      @start_date = Date.strptime(start_date, '%Y-%m-%d')
      @end_date = Date.strptime(end_date, '%Y-%m-%d')
    end
  end

  def _compute_target(target)
    if target.nil? &&
      @target = @children.map { |child| child.target * child.weight }.inject(0, :+) # sum
    else
      @target = target
    end
  end

  def _compute_start(start)
    if start.nil?
      @start = 0
      @children.each do |child|
        if child.start_date == @start_date
          @start += child.start
        end
      end
    else
      @start = start
    end
  end

  def calculate_number_of_days
    end_date.mjd - start_date.mjd
  end


end