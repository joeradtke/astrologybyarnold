class AddAttachementPhotoToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :photo_file_name,:string
    add_column :pages, :photo_content_type,:string
    add_column :pages, :photo_file_size,:integer
  end

  def self.down
    remove_column :pages, :photo_file_name,:string
    remove_column :pages, :photo_content_type,:string
    remove_column :pages, :photo_file_size,:integer
  end
end
