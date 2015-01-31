class CreateAspecta < ActiveRecord::Migration
  def change
    create_table :aspecta do |t|
      t.integer :pn
      t.string :name

      t.timestamps
    end
  end
end
