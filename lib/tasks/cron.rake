desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Rails.env.production? && Time.now.hour % 3 == 0
    Box.check_dead_mans_switches
  end
end
