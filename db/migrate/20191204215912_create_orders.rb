class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :dog_id
      t.integer :user_id
      t.datetime :datetime
      t.float :earnings
    end 
  end
end
