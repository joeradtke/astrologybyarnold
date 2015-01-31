class AddBirthplaceIdToBirth < ActiveRecord::Migration
  def change
    add_column :births, :birthplace_id, :integer
  end
end
