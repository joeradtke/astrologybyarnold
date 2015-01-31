class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.string :short
      t.text :description
      t.string :price
      t.references :category, index: true

      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
