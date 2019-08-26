require 'date'

class Milestone
  attr_reader :id, :objective_id, :target, :date

  def initialize(id, objective_id, target, date)
    @id = id
    @objective_id = objective_id
    @target = target
    @date = Date.parse(date)
  end

end