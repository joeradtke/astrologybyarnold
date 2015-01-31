class CreatePlanets < ActiveRecord::Migration
  def change
    create_table :planets do |t|
      t.string :name
      t.string :longitude
      t.string :house
      t.string :sign
      t.string :retrograde

      t.timestamps
    end
  end
end
