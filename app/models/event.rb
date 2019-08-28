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
  validates :status, presence: true
  validates :tickets_left, presence: true

  has_many :pages
  has_many :custom_emails
  has_many :profiles
  has_many :invitations

  STATUS = [:activo, :seleccion, :lleno, :finalizado]

  def aoc_dates
     "#{start_date.strftime('%d de %b')} al #{end_date.strftime('%d de %b')} de #{end_date.strftime('%Y')}"
  end

  def add_homepage
    unless(pages.any? {|page| page.path == default_page_path })
      content = File.read("#{Rails.root}/public/templates/default_markdown_page")
      pages << Page.new(path: default_page_path, content: content)
    end
  end

  def add_invitation_email
    unless(custom_emails.any? {|custom_email| custom_email.name == :notify_invitation })
      template = File.read("#{Rails.root}/public/templates/notify_invitation")
      custom_emails << CustomEmail.new(name: :notify_invitation, template: template, copy_to: support_mail)
    end
  end

  def default_page_path
    fullname.parameterize.underscore
  end

  def san_saru_details
    content = File.read("#{Rails.root}/public/templates/san_saru_markdown_page")
    content.html_safe
  end

  def has_invitations?
    self.tickets_left > 0
  end

  def discount_invitation
    if has_invitations?
      self.tickets_left -= 1
      close_invitation_period if self.tickets_left == 0
      save!
    else
      raise "Lo sentimos, ya no tenemos cupos disponibles :'("
    end
  end

  def add_one_invitation
    self.tickets_left += 1
    save!
  end

  def is_invitation_period_open?
    status == :seleccion.to_s or status == :lleno
  end

  def self.find_by_home_path (home_path)
    Event.all.select{|event| event.default_page_path == home_path}[0]
  end

private

  def close_invitation_period
    status = :lleno.to_s
  end




end
