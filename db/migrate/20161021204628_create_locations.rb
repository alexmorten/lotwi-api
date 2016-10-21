class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lng
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
