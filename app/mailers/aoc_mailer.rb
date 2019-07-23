class AocMailer < ApplicationMailer

  TEST_HEADER = {true: "[TEST] - ",false:""}

  def notify_invitation(invited, host, test = false)
    @invited = invited
    @host = host

    email_data = HtmlEmailParser.get_email_template(:notify_invitation, invited, host)
    @template = email_data[:template]
    mails = email_data[:copy_to]
    mails << @invited.email
    subject =  "#{TEST_HEADER[test]} ¡Bienvenid@ #{@invited.name} al AOC!"
    puts subject #TODO revisar que arme bien el subject al enviar el test.
    mail(to: mails, subject: subject)
  end

end
