class Event < ActiveRecord::Base
  has_many :likes
  has_many :users, :through => :likes
  belongs_to :sport
  validates :sport_id, presence: true
  validates :cover, presence: true
  validates :background, presence: true
  validates :description, presence: true
  validates :adresse, presence: true

  def self.find_by_sport(sport_id)
    Event.where(:sport_id => sport_id)
  end

  def self.find_one(event_id)
    Event.find(event_id) 
  end

  def self.find_all
    Event.all
  end

  def self.count
    Event.all.size()
  end

  def self.delete_one(event_id)
    Event.destroy(event_id)
  end
end
