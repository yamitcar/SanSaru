class AocMailer < ApplicationMailer

  def notify_invitation(invited, host)
    @invited = invited
    @host = host
    mail(to: @invited.email, subject: 'Bienvenido al AoC Colombia!')
  end

end