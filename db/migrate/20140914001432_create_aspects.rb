class CreateAspects < ActiveRecord::Migration
  def change
    create_table :aspects do |t|
      t.integer :pn1
      t.integer :pn2
      t.string :name
      t.string :p1name
      t.string :p2name

      t.timestamps
    end
  end
end
