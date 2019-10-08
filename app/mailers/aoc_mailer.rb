class AocMailer < ApplicationMailer

  TEST_HEADER = {true: "[TEST] - ",false:""}

  def notify_invitation(invited, host,event_id,test = false)
    @invited = invited
    @host = host
    @event_id = event_id

    email_data = HtmlEmailParser.get_email_template(:notify_invitation, invited, host,event_id)
    @template = email_data[:template]
    mails = email_data[:copy_to]
    mails << @invited.email
    subject =  "#{TEST_HEADER[test]} ¡Bienvenid@ #{@invited.name} al AOC!"
    mail(to: mails, subject: subject)
  end

end
