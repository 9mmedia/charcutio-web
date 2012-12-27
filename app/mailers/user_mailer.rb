class UserMailer < ActionMailer::Base
  default from: "info@charcut.io"

  def meat_down_email(box, user, last_update_time)
    @box = box
    @last_update_time = last_update_time
    mail(:to => user.email, :subject => "DANGER - MEAT DOWN!")
  end
end
