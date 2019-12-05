class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name 
      t.integer :age
      t.float :balance
    end 
  end
end
