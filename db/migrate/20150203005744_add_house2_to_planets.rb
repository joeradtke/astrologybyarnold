class AddHouse2ToPlanets < ActiveRecord::Migration
  def self.up
    add_column :planets, :house2,:string
  end

  def self.down
    remove_column :planets, :house2,:string
  end
end
