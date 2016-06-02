class CartsController < ApplicationController
  before_filter :set_cart, :only => [:show]
  def checkout
    @cart = current_cart
    @cart.line_items.each do |line_item|
      item= Item.find(line_item.item_id)
      item.inventory -= line_item.quantity
      item.save
    end
    current_user.current_cart = nil
    current_user.save
    redirect_to cart_path(@cart)
  end

  def show

  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

end
