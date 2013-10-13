class Ticket < ActiveRecord::Base
  has_one :status

  attr_accessible :description, :title, :reference, :customer_id, :status_id

  attr_accessor :name, :email

  def status_name
    Status.find(status_id).name
  end
end
