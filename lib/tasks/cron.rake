desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Rails.env.production?
    Box.check_dead_mans_switches if Time.now.hour % 3 == 0
    Box.check_if_meats_completed if Time.now.hour == 0
    Box.check_if_data_acceptable
  end
end
