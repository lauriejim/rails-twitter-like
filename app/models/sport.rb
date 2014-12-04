class Sport < ActiveRecord::Base
  has_many :events
  validates :icon, presence: true
  validates :title, presence: true, uniqueness: true

  def self.find
    Sport.all
  end
end
