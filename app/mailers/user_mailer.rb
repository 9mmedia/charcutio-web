class UserMailer < ActionMailer::Base
  default from: "info@charcut.io"

  def meat_down_email(box, team, last_update_time)
    @box = box
    @last_update_time = last_update_time
    mail(to: team.users.map(:&email), subject: "DANGER - MEAT DOWN!")
  end
end
