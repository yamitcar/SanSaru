class Event < ApplicationRecord
  has_paper_trail
  validates :name, presence: true
  validates :fullname, presence: true
  validates :site, presence: true
  validates :support_mail, presence: true
  validates :participants, presence: true
  validates :price, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :venue, presence: true
  validates :venue_location, presence: true
  validates :monkeys, presence: true
  validates :active, presence: true

  has_many :pages

  #
  # :name,:fullname,, :site,
  #                                     :support_mail,:participants, :price,
  #                                     :reserve_price, :ideal_price,:start_date,
  #                                     :end_date,  :venue, :venue_location, :monkeys
  #

  def aoc_dates
     "#{start_date.strftime('%d de %b')} al #{end_date.strftime('%d de %b')} de #{end_date.strftime('%Y')}"
  end

end
