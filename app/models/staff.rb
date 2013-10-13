require 'digest/sha2'

class Staff < ActiveRecord::Base

  has_many :tickets

  attr_accessible :username, :email
  attr_accessor :password
  attr_protected :hashed_password
  attr_protected :salt

  #VALIDATION
  validates :username, :length => { :within => 3..25 }, :uniqueness => true
  validates_length_of :password, :within => 3..25, :on => :create

  #CALLBACK of DB running
  before_save :create_hashed_password
  after_save :clear_password

  #Advanced query with input params
  #scope :sorted, order("users.username ASC")

  def name
    "#{username}"
  end

  def self.authenticate(username="", password="")
    user = Staff.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end

  def password_match?(password="")
    hashed_password == Staff.hash_with_salt(password, salt)
  end

  def self.make_salt(username="")
    Digest::SHA2.hexdigest("Use #{username} with #{Time.now} to make salt")
  end

  def self.hash_with_salt(password="", salt="")
    Digest::SHA2.hexdigest("Mixed #{salt} with #{password}")
  end

  private

  def create_hashed_password
    unless password.blank?
      # always use "self" when assigning values
      self.salt = Staff.make_salt(username) if salt.blank?
      self.hashed_password = Staff.hash_with_salt(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end
end
