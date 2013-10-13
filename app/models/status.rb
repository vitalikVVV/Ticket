class Status < ActiveRecord::Base

  belongs_to :ticket

  attr_accessible :name
end
