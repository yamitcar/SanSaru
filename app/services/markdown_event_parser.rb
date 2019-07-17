class MarkdownEventParser

  POSSIBILITIES = ['name','fullname','site','support_mail','san_saru_details',
                   'participants','price','reserve_price','ideal_price',
                   'start_date','end_date','aoc_dates','venue',
                   'venue_location','monkeys'
  ]

  def self.add_event_details(event, markdown)
    POSSIBILITIES.each do |method_name|
      if event.respond_to?(method_name)
        regex = "{{{ #{method_name} }}}"
        markdown.gsub!(/#{regex}/, event.public_send(method_name).to_s)
      end
    end
    markdown
  end

end