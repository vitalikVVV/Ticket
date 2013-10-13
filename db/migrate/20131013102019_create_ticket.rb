class CreateTicket < ActiveRecord::Migration
  def change
      create_table :tickets do |t|
        t.string :title
        t.text :description
        t.string :reference
        t.text :history

        t.integer :staff_id
        t.integer :customer_id
        t.integer :status_id
        t.timestamps
      end
  end
end
