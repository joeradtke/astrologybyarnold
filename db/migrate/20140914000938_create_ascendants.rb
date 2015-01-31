class CreateAscendants < ActiveRecord::Migration
  def change
    create_table :ascendants do |t|
      t.string :name
      t.text :body
      t.integer :sign_no

      t.timestamps
    end
  end
end
