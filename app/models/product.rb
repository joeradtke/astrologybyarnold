class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  extend FriendlyId
  friendly_id :name, :use=>[:slugged,:finders]

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors[:base] << "Line Items present"
      return false
    end
  end
end
