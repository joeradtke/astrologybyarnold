class CreateAspecttexts < ActiveRecord::Migration
  def change
    create_table :aspecttexts do |t|
      t.integer :pn1
      t.integer :pn2
      t.string :name
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
