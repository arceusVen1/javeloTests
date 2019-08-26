# !/usr/bin/env ruby,
# frozen_string_literal: true

require_relative 'objective'
require_relative 'progressive_record'
require_relative 'milestone'
require 'json'

raw_data = File.read('./data/input.json')

data = JSON.parse(raw_data)

objectives_list = {}
children_list = {}
milestones_list = {}

data['milestones'].each do |milestone|
  milestone_object = Milestone.new(milestone['id'],
                                   milestone['objective_id'],
                                   milestone['target'],
                                   milestone['date'])
  if milestones_list.key?(milestone['objective_id'])
    milestones_list[milestone['objective_id']].push(milestone_object)
  else
    milestones_list[milestone['objective_id']] = [milestone_object]
  end
end

data['objectives'].each do |objective|

   objective_object = Objective.new(objective['id'],
                                    objective['start'],
                                    objective['target'],
                                    objective['start_date'],
                                    objective['end_date'],
                                    objective['parent_id'],
                                    objective['weight'],
                                    children_list[objective['id']],
                                    milestones_list[objective['id']].nil? ? [] : milestones_list[objective['id']])
   objectives_list[objective['id']] = objective_object
   if children_list.key?(objective['parent_id'])
     children_list[objective['parent_id']].push(objective_object)
   else
     children_list[objective['parent_id']] = [objective_object]
   end
end




res = { progress_records: [] }
data['progress_records'].each do |progress_record|
  progressive_record = ProgressiveRecord.new(progress_record['id'],
                                             objectives_list[progress_record['objective_id']],
                                             progress_record['value'],
                                             progress_record['date'])
  progress_record_info = {
    id: progressive_record.id,
    excess: progressive_record.calculate_excess
  }
  res[:progress_records].push(progress_record_info)
end

File.write('data/output.json', JSON.pretty_generate(res))
