class AddLongitude3ToPlanet < ActiveRecord::Migration
  def self.up
    add_column :planets, :longitude3,:string
  end

  def self.down
    remove_column :planets, :longitude3,:string
  end
end
