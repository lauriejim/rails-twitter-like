require 'digest/md5'

class User < ActiveRecord::Base
  validates :firstname, :lastname, :email, :password, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  before_create :hash
  before_update :hash

  private
  def hash
    self.password = Digest::MD5.hexdigest(self.password)
  end
end
