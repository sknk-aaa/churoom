class CreateOccupancies < ActiveRecord::Migration[8.0]
  def change
    create_table :occupancies do |t|
      t.string :day
      t.integer :time
      t.string :number

      t.timestamps
    end

    add_index :occupancies, [ :day, :time ]

    add_index :occupancies, [ :day, :time, :number ],
              unique: true, name: "idx_occ_unique_slot_room"
  end
end
