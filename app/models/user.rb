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
  has_many :favorites
  has_many :admin_for_events

  validates :terms_of_service, :acceptance => true
  attr_accessor :user_ids

  belongs_to :actual_event, class_name: 'Event', :foreign_key => 'actual_event_id', optional: true

  def full_name
    "#{name} #{lastname}"
  end

  def admin?
    user_type == :admin.to_s
  end

  def is_event_admin?
    !admin_for_events.empty?
  end

  def is_admin_for_event?(event_id)
    if(event_id)
      !admin_for_events.select {|afe| afe.event.id.to_s == event_id }.empty?
    else
      is_event_admin?
    end
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

  def uninvite(current_user, invited)
    begin
      if(current_user.admin?)
        if(invited.has_sons?)
          Invitation.clean_invitation_parent(invited,current_user.actual_event.id)
        else
          Invitation.clean_invitation_son(invited, current_user.actual_event.id)
        end
        current_user.actual_event.add_one_invitation
        invited.profile.locked_profile

        # TODO notificar la baja

      end
    rescue ActiveRecord::RecordInvalid => exception
      error = exception.message
    end
    error
  end

  def has_invitation?
    invitation = Invitation.find_invitation_for(id,actual_event.id)
    if invitation
      return (invitation.invited_one.nil? || invitation.invited_two.nil?)
    end
    false
  end

  def has_sons?
    invitation = Invitation.find_invitation_for(id,actual_event.id)
    if invitation
      return (invitation.invited_one or invitation.invited_two)
    end
  end

  def was_pay?
    if has_invitation?
      Invitation.find_invitation_for(id, actual_event.id).payed
    else
      false
    end
  end

  def was_invite?
    Invitation.all_invitations_for(actual_event.id).map(&:user_id).index id
  end

  def is_favorite?(user)
    favorites.include?(user)
  end

  def user_favorites
    ids = favorites.map do |favorite|
      if (favorite.event_id == actual_event.id and favorite.favorite_user_id != nil)
        favorite.favorite_user_id
      end
    end
    User.find(ids.compact)
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
    Invitation.create!(user_id: invited.id, event_id: actual_event.id)
  end
end
# TODO no permitir borrar cuenta

