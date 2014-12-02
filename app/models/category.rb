class Category < ActiveRecord::Base
  validates :icon, presence: true
  validates :title, presence: true, uniqueness: true
end
