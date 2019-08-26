# !/usr/bin/env ruby,
# frozen_string_literal: true

require_relative 'objective'
require_relative 'progressive_record'
require_relative 'milestone'
require 'json'

raw_data = File.read('./data/input.json')

data = JSON.parse(raw_data)

objectives_list = {}
milestones_list = {}

data['objectives'].each do |objective|
  objectives_list[objective['id']] = Objective.new(objective['id'],
                                                   objective['start'],
                                                   objective['target'],
                                                   objective['start_date'],
                                                   objective['end_date'])
end

data['milestones'].each do |milestone|
  milestone_object = Milestone.new(milestone['id'],
                                   objectives_list[milestone['objective_id']],
                                   milestone['target'],
                                   milestone['date'])
  if milestones_list.key?(milestone['objective_id'])
    milestones_list[milestone['objective_id']].push(milestone_object)
  else
    milestones_list[milestone['objective_id']] = [milestone_object]
  end
end

res = { progress_records: [] }
data['progress_records'].each do |progress_record|
  progressive_record = ProgressiveRecord.new(progress_record['id'],
                                             objectives_list[progress_record['objective_id']],
                                             progress_record['value'],
                                             progress_record['date'],
                                             milestones_list[progress_record['objective_id']])
  progress_record_info = {
    id: progressive_record.id,
    excess: progressive_record.calculate_excess
  }
  res[:progress_records].push(progress_record_info)
end

File.write('data/output.json', JSON.pretty_generate(res))
