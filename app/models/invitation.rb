class Invitation < ApplicationRecord
  has_paper_trail
  belongs_to :invited_one, class_name: 'User', optional: true
  belongs_to :invited_two, class_name: 'User', optional: true
  belongs_to :user, class_name: 'User'

  belongs_to :event


  def self.build_invitation_trees(event)
    trees = []
    aoc_name = "AOC"
    roots = Invitation.where(monkey: true).where(event_id: event.id)
    roots.each do |root|
      node = build_node event,root, aoc_name
      trees.push(node)
    end
    trees

    final_tree = []
    node = { name: aoc_name, parent: nil, payed: true }
    trees.each do |tree|
      node[:children].nil? ? node[:children] = [tree] : node[:children].push(tree)
    end
    final_tree.push(node)

    final_tree
  end

  def self.clean_invitation_son(invited, event_id)
    begin
      ActiveRecord::Base.transaction do
        find_invitation_for(invited.id,event_id).delete
        invitation_parent = where(invited_one_id: invited.id).or(where(invited_two_id: invited.id)).first
        if(invitation_parent)
          if(invitation_parent&.invited_one&.id == invited.id)
            invitation_parent&.invited_one = nil
            invitation_parent&.one_on = nil
          else
            invitation_parent&.invited_two = nil
            invitation_parent&.two_on = nil
          end
          invitation_parent.save!
        end
      end
    end
  end

  def self.clean_invitation_parent(invited, event_id)
    invitation = find_invitation_for(invited.id,event_id)
    invitation.payed = false
    invitation.save!
  end

  def self.find_ids_by_event(event_id)
    Invitation.where(event_id: event_id).map(&:user_id)
  end

  private

  def self.build_node(event,invitation, parent = nil)
    name = "#{invitation.user.name} #{invitation.user.lastname}"
    node = { name: name, parent: parent, payed: invitation.payed }
    if invitation.invited_one
      son = build_node(event, find_invitation_for(invitation.invited_one.id, event.id), name)
      node[:children].nil? ? node[:children] = [son] : node[:children].push(son)
    end

    if invitation.invited_two
      son = build_node(event, find_invitation_for(invitation.invited_two.id, event.id), name)
      node[:children].nil? ? node[:children] = [son] : node[:children].push(son)
    end

    node
  end

  def self.find_invitation_for (user_id,event_id)
    Invitation.where(user_id: user_id).where(event_id: event_id).first
  end

  def self.all_invitations_for (event_id)
    Invitation.where(event_id: event_id)
  end
end
