class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :load_name
      t.integer :route
      t.date :date
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
