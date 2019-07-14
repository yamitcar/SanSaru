class Event < ApplicationRecord
  has_paper_trail
  validates :name, presence: true
  validates :fullname, presence: true, uniqueness: true
  validates_uniqueness_of :fullname
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
  has_many :profiles

  def aoc_dates
     "#{start_date.strftime('%d de %b')} al #{end_date.strftime('%d de %b')} de #{end_date.strftime('%Y')}"
  end

  def add_homepage
    content = File.read("#{Rails.root}/public/default_markdown_page")
    pages << Page.new(path: default_page_path, content: content)
  end

  def default_page_path
    fullname.parameterize.underscore
  end

end
