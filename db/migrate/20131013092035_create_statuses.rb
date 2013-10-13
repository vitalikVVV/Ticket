class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :name
      t.timestamps
    end

    #predefined statuses
    Status.create :name => "Waiting for Staff Response"
    Status.create :name => "Waiting for Customer"
    Status.create :name => "On Hold"
    Status.create :name => "Cancelled"
    Status.create :name => "Completed"
  end

  def self.down
    drop_table :statuses
  end
end
