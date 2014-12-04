class Sport < ActiveRecord::Base
  has_many :events
  validates :icon, presence: true
  validates :title, presence: true, uniqueness: true

  def self.index
    Sport.all
  end

  def self.findOne(sport_id)
    Sport.where(:id => sport_id)
  end
end
