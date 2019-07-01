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



#remember to run whenever --update-crontab
set :output, '~/Git/backendMe-Me/tmp/crons.log'
every :sunday, at: '1:00 am' do
  command "echo 'rake db:explicit_image started at: $(date)'"
  rake 'db:explicit_image'
  command "echo 'rake db:explicit_image ended at: $(date)'"
end

# every 1.minute do
#   command "echo 'yes bitch'"
# end