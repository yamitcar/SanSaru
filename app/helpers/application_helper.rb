module ApplicationHelper

  # Repetir esto en config/initializers/rails_admin.rb, en la llamada a config.main_app_name (porque es previo a esto)
  def aoc_name
      current_user&.actual_event&.name || 'Agile Open Camp'
  end

  def aoc_fullname
    current_user&.actual_event&.fullname || 'AOC - San Saru'
  end

  def aoc_site
    current_user&.actual_event&.site || 'http://agileopen.camp/'
  end

  def aoc_mail
    current_user&.actual_event&.support_mail || ''
  end

  def aoc_reserve
    current_user&.actual_event&.reserve_price || ''
  end

  def aoc_price
    current_user&.actual_event&.price || ''
  end

  def aoc_price_ideal
    current_user&.actual_event&.ideal_price || ''
  end

  def aoc_limit
    current_user&.actual_event&.participants || ''
  end

  def aoc_dates
    current_user&.actual_event&.aoc_dates || ''
  end

  def aoc_venue
    current_user&.actual_event&.venue || ''
  end

  def aoc_venue_location
    current_user&.actual_event&.venue_location || ''
  end

  def aoc_monkeys
    current_user&.actual_event&.monkeys || ''
  end
end
