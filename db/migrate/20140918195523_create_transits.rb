class CreateTransits < ActiveRecord::Migration
  def change
    create_table :transits do |t|
      t.string :name
      t.string :date
      t.string :date2
      t.string :city

      t.timestamps
    end
  end
end
