class Sport < ActiveRecord::Base
  has_many :events
  validates :icon, presence: true
  validates :title, presence: true, uniqueness: true

  def self.index
    Sport.all
  end

  def self.find_one(sport_id)
    Sport.find_by_id(sport_id)
  end

  def self.count
    Sport.all.size()
  end

  def self.delete_one(sport_id)
    Sport.destroy(sport_id)
  end
end
