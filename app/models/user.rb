class User < ApplicationRecord
  has_paper_trail
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

  has_many :profiles
  has_one :invitation
  has_and_belongs_to_many :favorites,
                          class_name: 'User',
                          join_table:  :favorites,
                          foreign_key: :user_id,
                          association_foreign_key: :favorite_user_id

  validates :terms_of_service, :acceptance => true
  attr_accessor :user_ids

  belongs_to :actual_event, class_name: 'Event', :foreign_key => 'actual_event_id', optional: true

  def full_name
    "#{name} #{lastname}"
  end

  def profile
    profiles.where(event_id: actual_event_id).first
  end

  def organizer
    profile&.organizer || false
  end

  def invite(invited)
    invitation = Invitation.find_by(user_id: id)
    if invitation
      begin
        ActiveRecord::Base.transaction do
          if actual_event.has_invitations?
            formalize_invitation invitation, invited
            actual_event.discount_invitation
          end
        end
      rescue ActiveRecord::RecordInvalid => exception
        error = exception.message
      end
    else
      error = 'No tienes permitido invitar a nadie aún'
    end
    error
  end

  def has_invitation?
    invitation = Invitation.find_by(user_id: id)
    if invitation
      return (invitation.invited_one.nil? || invitation.invited_two.nil?)
    end
    false
  end

  def was_pay?
    if has_invitation?
      Invitation.find_by(user_id: id).payed
    else
      false
    end
  end

  def was_invite?
    Invitation.all.map(&:user_id).index id
  end

  def is_favorite?(user)
    favorites.include?(user)
  end

  private

  def formalize_invitation(invitation, invited)
    if invitation.invited_one.nil?
      invitation.invited_one = invited
      invitation.one_on = Time.now
    elsif invitation.invited_two.nil?
      invitation.invited_two = invited
      invitation.two_on = Time.now
    else
      raise 'Ya invitaste a dos personas'
    end
    invitation.save!
    Invitation.create!(user_id: invited.id)
  end
end
# TODO no permitir borrar cuenta

