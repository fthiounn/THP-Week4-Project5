class CreateUserReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reservations do |t|
      t.references :guest, index: true
      t.belongs_to :reservation
      t.timestamps
    end
  end
end
