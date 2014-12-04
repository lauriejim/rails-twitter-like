class Event < ActiveRecord::Base
  belongs_to :sport
  validates :sport_id, presence: true

  def self.findBySport(sport_id)
    Event.where(:sport_id => sport_id)
  end

  def self.findOne(event_id)
    Event.find(event_id)
  end
end
