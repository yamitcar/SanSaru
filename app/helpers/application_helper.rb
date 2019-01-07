module ApplicationHelper

  # Repetir esto en config/initializers/rails_admin.rb, en la llamada a config.main_app_name (porque es previo a esto)
  def aoc_name
    "AOC Bariloche 2019"
  end

  def aoc_fullname
    "Agile Open Camp Bariloche 2019"
  end

  def aoc_site
    "http://argentina.agileopen.camp/"
  end

  def aoc_mail
    "argentina@agileopen.camp"
  end

  def aoc_reserve
    "USD 50"
  end

  def aoc_price
    "USD 150"
  end

  def aoc_limit
    75
  end

  def aoc_dates
    "10 al 14 de abril de 2019"
  end

  def aoc_food
    "Desde la cena del miércoles 10 de abril hasta el desayuno del domingo 14 de abril"
  end

  def aoc_venue
    "Hotel Tronador"
  end

  def aoc_venue_location
    "dentro del Parque Nacional Nahuel Huapi, en Bariloche"
  end

  def aoc_monkeys
    "Tommy Christie, María Thompson y Martín Salías"
  end
end
