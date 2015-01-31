class CreateNatals < ActiveRecord::Migration
  def change
    create_table :natals do |t|
      t.string :name
      t.string :date
      t.string :city

      t.timestamps
    end
  end
end
