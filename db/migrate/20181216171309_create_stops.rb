class CreateStops < ActiveRecord::Migration[5.2]
  def change
    create_table :stops do |t|
      t.references :route_id, foreign_key: true
      t.timestamp :arrived_time
      t.integer :charge
      t.string :latitude
      t.string :length

      t.timestamps
    end
  end
end
