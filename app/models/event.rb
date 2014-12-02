class Event < ActiveRecord::Base
  belongs_to :sport
  validates :sport_id, presence: true
end
