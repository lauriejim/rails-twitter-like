require 'digest/md5'

class User < ActiveRecord::Base
  validates :firstname, :lastname, :email, presence: true
  validates :password, presence: true, :on => :create
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  before_create :encrypt
  before_update :encrypt

  def self.index
    User.all
  end

  def self.find_one(user_id)
    User.find(user_id) 
  end

  def self.count
    User.all.size()
  end

  def self.delete_one(user_id)
    User.destroy(user_id)
  end

  private
  def encrypt
    if self.password
      self.password = Digest::MD5.hexdigest(self.password)
    else
      self.password = nil
    end
  end
end
