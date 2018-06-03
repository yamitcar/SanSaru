class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    validates :lastname, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

    belongs_to :profile, required: false
    has_one :invitation


  def invite invited
    invitation = Invitation.find_by(user_id: self.id)
    if invitation
      begin
        ActiveRecord::Base.transaction do
        if Config.has_invitations?
          formalize_invitation invitation,invited
          Config.discount_invitation
        end
      end
      rescue ActiveRecord::RecordInvalid => exception
        error = exception.message
      end
    else
      error = "No tienes permitido invitar a nadie aún"
    end
    return error
  end

  def has_invitation?
    invitation = Invitation.find_by(user_id: self.id)
    if invitation
      return (invitation.invited_one==nil or invitation.invited_two == nil)
    end
    return false
  end

  def was_pay?
    if has_invitation?
      Invitation.find_by(user_id: self.id).payed
    else
      false
    end
  end

  def was_invite?
    Invitation.all.map(&:user_id).index self.id
  end

  private

  def formalize_invitation invitation, invited
    if invitation.invited_one == nil
      invitation.invited_one = invited
      invitation.one_on = Time.now
    elsif invitation.invited_two == nil
      invitation.invited_two = invited
      invitation.two_on = Time.now
    else
      raise "Ya invitaste a dos personas"
    end
      invitation.save!
      Invitation.create!(user_id: invited.id)
  end



end
# TODO poner textos en español y plantillas de email
# TODO no permitir borrar cuenta