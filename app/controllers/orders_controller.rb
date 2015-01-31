class OrdersController < InheritedResources::Base
  before_action :authenticate_user!

  def new
    if current_cart.line_items.empty?
      redirect_to root_path, :notice => "Your cart is empty"
      return
    end
    @order=Order.new
    respond_to do |format|
      format.html #new.html.erb
      format.xml {render :xml=>@order}
    end
  end
end
