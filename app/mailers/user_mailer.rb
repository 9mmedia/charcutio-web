class UserMailer < ActionMailer::Base
  default from: "info@charcut.io"
  default_url_options[:host] = request.host_with_port

  def completed_meat_email(meat, team)
    @meat = meat
    mail(to: team.users.map(&:email), subject: "Your meat is ready to eat!")
  end

  def curing_completed_email(meat, team)
    @meat = meat
    mail(to: team.users.map(&:email), subject: "Your meat is done curing!")
  end

  def fermenting_completed_email(meat, team)
    @meat = meat
    mail(to: team.users.map(&:email), subject: "Your meat is done fermenting!")
  end

  def meat_down_email(box, team, dead_data_point)
    @box = box
    @dead_data_point = dead_data_point
    mail(to: team.users.map(&:email), subject: "DANGER - MEAT DOWN!")
  end

  def sensor_alert_email(box, team, data_type, average_value, desired_value, difference)
    @box = box
    @data_type = data_type
    @average_value = average_value
    @desired_value = desired_value
    @difference = difference
    mail(to: team.users.map(&:email), subject: "DANGER - Box #{@data_type} is off by #{@difference}!")
  end
end
