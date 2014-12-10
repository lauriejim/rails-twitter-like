class Event < ActiveRecord::Base
  belongs_to :sport
  validates :sport_id, presence: true

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
