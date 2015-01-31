class CreateBirthplaces < ActiveRecord::Migration
  def change
    create_table :birthplaces do |t|
      t.string :city
      t.string :longitude
      t.string :latitude
      t.string :timezone

      t.timestamps
    end
  end
end
