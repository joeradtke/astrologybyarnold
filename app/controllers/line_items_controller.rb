class LineItemsController < ApplicationController
  def create
    @cart=current_cart
    product=Product.find(params[:product_id])
    @line_item=@cart.add_product(product.id)
    respond_to do |format|
      if @line_item.save
        format.html {redirect_to root_path}
 	format.js {@current_item=@line_item}
	format.xml {render :xml=>@line_item, :status=>:created,:location=>@line_item}
      else
	format.html {render :action=>"new"}
	format.xml {render :xml=>@line_item.errors, :status=>:unprocessable_entity}
      end
    end
  end
  def update
    @line_item=LineItem.find(params[:id])
    @cart=current_cart
    @line_item=@cart.update_product(@line_item,params[:line_item][:quantity])
    respond_to do |format|
      if @line_item==nil
        format.html {redirect_to :back,notice:  "cart was updated"}
        format.js {@current_item=@line_item}
        format.xml {head :ok}
      elsif @line_item.save
        format.html {redirect_to :back,notice:  "cart was updated"}
        format.js {@current_item=@line_item}
        format.xml {head :ok}
      else
	format.html {render action: "new"}
      end
    end
  end
end
