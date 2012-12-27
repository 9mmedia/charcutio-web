class UserMailer < ActionMailer::Base
  default from: "info@charcut.io"

  def completed_meat_email(meat, team)
    @meat = meat
    mail(to: team.users.map(:&email), subject: "Your meat is ready to eat!")
  end

  def meat_down_email(box, team, last_update_time)
    @box = box
    @last_update_time = last_update_time
    mail(to: team.users.map(:&email), subject: "DANGER - MEAT DOWN!")
  end
end
