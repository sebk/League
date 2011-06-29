class Team < ActiveRecord::Base
  has_many :participations
  has_many :teammemberships
  has_many :users, :through => :teammemberships
  has_many :ladders, :through => :participations


  validates_presence_of :name

  def joins(ladder)
    p = self.participations.build(:ladder_id => ladder.id)
    p.save
  end

  def leaves(ladder)
    p = self.participations.where(:ladder_id => ladder.id).first
    p.destroy
  end

  scope :without_user, proc{ |user| { :conditions => ['id not in (?)', user.team_ids]  }}

  scope :singleplayer, where(:singleplayer => true)

  scope :multiplayer, where(:singleplayer => false)


end
