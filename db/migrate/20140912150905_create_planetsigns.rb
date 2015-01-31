class CreatePlanetsigns < ActiveRecord::Migration
  def change
    create_table :planetsigns do |t|
      t.integer :planetno
      t.integer :signno
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
