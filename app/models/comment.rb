class Comment < ActiveRecord::Base
  validates :message, presence: true
  belongs_to :user
  belongs_to :event
end
