class CreatePlanethouses < ActiveRecord::Migration
  def change
    create_table :planethouses do |t|
      t.integer :planetno
      t.integer :houseno
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
