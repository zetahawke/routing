class AddColumnStatusToRoute < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :status, :string
  end
end
