class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.date :arrival_date
      t.date :departure_date
      t.references :hotel, null: false, foreign_key: true
      t.integer :number_of_rooms

      t.timestamps
    end
  end
end
