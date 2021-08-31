class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :city
      t.integer :number_of_rooms
      t.decimal :price

      t.timestamps
    end
  end
end
