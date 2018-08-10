class Config < ApplicationRecord
  has_paper_trail
  validates :name, presence: true
  validates :value, presence: true

  def self.has_invitations?
    Config.find_by(name: :invitaciones).value.to_i > 0
  end

  def self.count_invitations
    Config.find_by(name: :invitaciones).value.to_i
  end

  def self.discount_invitation
    cupos = Config.find_by(name: :invitaciones)
    value = cupos.value.to_i
    if value.to_i > 0
      value -= 1
      cupos.value = value.to_s
      cupos.save!

      #close_invitation_period if value == 0
    else
      raise "Lo sentimos, ya no tenemos cupos disponibles :'("
    end
  end

  def self.close_invitation_period
    eleccion = Config.find_by(name: :eleccion)
    eleccion.value = 'false'
    eleccion.save!
  end

  def self.is_invitation_period_open?
    Config.find_by(name: :eleccion).value == 'true'
  end
end
