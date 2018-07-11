class AocMailer < ApplicationMailer

  def notify_invitation(invited, host)
    @invited = invited
    @host = host
    mail(to: [@invited.email,ENV['MAIL_USERNAME']], subject: "#{@invited.name}, Bienvenido al AoC Colombia!")
  end

end