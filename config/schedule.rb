# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :output, 'log/bug.log'
every :hour do
  rake 'fetch_animegifs'
end

every 1.day, :at => '5:00 am' do
  rake "sitemap:refresh"
end

# API stuff, maybe next time? No reason to refresh
# every :month do 
# 	rake 'dota_api'
# end

# every 3.months do 
# 	rake 'lol'
# end