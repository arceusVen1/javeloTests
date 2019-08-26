require 'date'

class Milestone
  attr_reader :id, :objective, :target, :date

  def initialize(id, objective, target, date)
    @id = id
    @objective = objective
    @target = target
    @date = Date.parse(date)
  end

end