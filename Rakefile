#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

CharcutioWeb::Application.load_tasks

namespace :test_data do 
	task :add_point => :environment do
		@box = Box.first
		data_point = DataPoint.create!(box: @box, data_type: "temperature", value: (10+rand(5)))
		@box.data_points << data_point
		sleep 29
		data_point = DataPoint.create!(box: @box, data_type: "temperature", value: (10+rand(5)))
		@box.data_points << data_point
	end
end