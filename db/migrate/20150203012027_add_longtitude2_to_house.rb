class AddLongtitude2ToHouse < ActiveRecord::Migration
  def self.up
    add_column :houses, :longitude2,:string
  end

  def self.down
    remove_column :houses, :longitude2,:string
  end
end
