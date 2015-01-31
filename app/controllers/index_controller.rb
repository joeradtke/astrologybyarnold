class IndexController < ApplicationController
  def index
    @page=Page.find(1)
  end

  def about
    @page=Page.find(2)
  end

  def contact
    @page=Page.find(3)
  end
end
