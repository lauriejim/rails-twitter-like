require 'digest/md5'

class User < ActiveRecord::Base
  validates :firstname, :lastname, :email, presence: true
  validates :password, presence: true, :on => :create
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  before_create :hash
  before_update :hash

  def self.index
    User.all
  end

  def self.find_one(event_id)
    User.find(event_id) 
  end

  def self.count
    User.all.size()
  end

  def self.delete_one(event_id)
    User.destroy(event_id)
  end

  def self.auth(auth_info)
    password = Digest::MD5.hexdigest(auth_info['password'])
    user = User.where("email = ?", auth_info['email']).take!
  end

  private
  def hash
    if self.password
      self.password = Digest::MD5.hexdigest(self.password)
    else
      self.password = nil
    end
  end
end
