class CreateAspectatexts < ActiveRecord::Migration
  def change
    create_table :aspectatexts do |t|
      t.integer :pn
      t.string :name
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
