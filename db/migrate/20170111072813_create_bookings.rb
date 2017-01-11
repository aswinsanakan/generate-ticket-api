class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :reference_num

      t.timestamps null: false
    end
  end
end
