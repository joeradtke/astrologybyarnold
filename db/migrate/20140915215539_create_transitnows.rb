class CreateTransitnows < ActiveRecord::Migration
  def change
    create_table :transitnows do |t|
      t.string :name
      t.string :date
      t.string :city

      t.timestamps
    end
  end
end
