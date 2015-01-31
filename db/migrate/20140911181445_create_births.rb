class CreateBirths < ActiveRecord::Migration
  def change
    create_table :births do |t|
      t.string :name
      t.string :city
      t.datetime :date

      t.timestamps
    end
  end
end
