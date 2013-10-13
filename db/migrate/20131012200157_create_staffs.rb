class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string   "username",        :limit => 25 , :null => false
      t.string   "email",           :limit => 100, :default => '', :null => false
      t.string   "hashed_password", :limit => 64, :null => false
      t.string   "salt",            :limit => 64
      t.timestamps
    end
  end
end
