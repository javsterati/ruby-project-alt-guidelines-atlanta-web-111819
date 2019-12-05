class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name 
      t.integer :age
      t.string :owner_name
    end 
  end
end
