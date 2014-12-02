class Category < ActiveRecord::Base
  has_many :events
  validates :icon, presence: true
  validates :title, presence: true, uniqueness: true
end
