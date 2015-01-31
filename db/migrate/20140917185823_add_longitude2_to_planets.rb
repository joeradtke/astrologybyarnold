class AddLongitude2ToPlanets < ActiveRecord::Migration
  def self.up
    add_column :planets, :longitude2,:string
  end

  def self.down
    remove_column :planets, :longitude2,:string
  end
end
