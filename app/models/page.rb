class Page < ActiveRecord::Base
  has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates :title,:body,:presence=>true
end
