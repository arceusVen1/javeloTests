# !/usr/bin/env ruby,
# frozen_string_literal: true

require_relative 'objective'
require_relative 'progressive_record'
require 'json'

raw_data = File.read('./data/input.json')

data = JSON.parse(raw_data)

objectives_list = []

data['objectives'].each do |objective|
  objectives_list[objective['id']] = Objective.new(objective['id'],
                                                   objective['start'],
                                                   objective['target'],
                                                   objective['start_date'],
                                                   objective['end_date'])
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
