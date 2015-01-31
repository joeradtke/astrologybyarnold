class CreateRetrogradetexts < ActiveRecord::Migration
  def change
    create_table :retrogradetexts do |t|
      t.integer :pn
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
