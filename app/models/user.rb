require 'digest/md5'

class User < ActiveRecord::Base
  validates :firstname, :lastname, :email, :password, presence: true
  validates :password, :allow_blank => true, :on => :update
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  before_save :hash

  private
  def hash
    unless self.password
      self.password = Digest::MD5.hexdigest(self.password)
    else
      self.password = nil
    end
  end
end
