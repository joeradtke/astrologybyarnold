class Category < ActiveRecord::Base
  has_many :products 
  extend FriendlyId
    friendly_id :name, :use=>[:slugged,:finders]
end
