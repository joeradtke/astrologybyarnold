class ProductController < ApplicationController
  before_action :set_category
  before_action :set_product,only: :show
  def show
  end
  private 
    def set_category
      @category=Category.find(params[:category_id])
    end
    def set_product
      @product=Product.find(params[:id])
    end
end
