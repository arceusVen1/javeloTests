class Objective
  attr_reader :id, :start, :target

  def initialize(id, start, target)
    @id = id
    @start = start
    @target = target
  end
end