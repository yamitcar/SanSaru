class HtmlEmailParser

  POSSIBILITIES = ['invited.name','host.name','event.name','event.fullname','event.site','event.support_mail','event.san_saru_details',
                   'event.participants','event.price','event.reserve_price','event.ideal_price',
                   'event.start_date','event.end_date','event.aoc_dates','event.venue',
                   'event.venue_location','event.monkeys'
  ]



  def self.get_email_template(email_name, invited, host)
    custom_email = host.actual_event.custom_emails.select{|custom_email| custom_email.name === email_name.to_s}[0]
    actors = {'invited' => invited,'host' => host, 'event' => host.actual_event }
    template = custom_email.template
    POSSIBILITIES.each do |method_name|
      possibility = method_name.split('.')
      if(actors[possibility[0]].respond_to?(possibility[1]))
        regex = "{{{ #{method_name} }}}"
        template.gsub!(/#{regex}/, actors[possibility[0]].public_send(possibility[1]).to_s)
      end
    end
    {template: template, copy_to: custom_email.copy_to.split(',')}
  end

end