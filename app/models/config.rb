class Config < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true

  def self.has_invitations?
    return Config.find_by(name: :invitaciones).value.to_i > 0
  end

  def self.discount_invitation
    cupos = Config.find_by(name: :invitaciones)
    value = cupos.value.to_i
    if value.to_i > 0
      value -= 1
      cupos.value = value.to_s
      cupos.save!
    else
      raise "Lo sentimos, ya no tenemos cupos disponibles :'("
    end
  end
end
