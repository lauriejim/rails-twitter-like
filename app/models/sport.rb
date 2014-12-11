class Sport < ActiveRecord::Base
  has_many :events
  has_many :follows
  has_many :users, :through => :follows
  validates :icon, presence: true
  validates :title, presence: true, uniqueness: true
  validates :background, presence: true
  validates :color, presence: true


  def self.index
    Sport.all
  end

  def self.find_one(sport_id)
    Sport.find(sport_id)
  end

  def self.count
    Sport.all.size()
  end

  def self.delete_one(sport_id)
    Sport.destroy(sport_id)
  end
end
