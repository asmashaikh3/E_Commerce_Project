class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
  end

  
  def add
    product_id = params[:product_id].to_s
    quantity = (params[:quantity] || 1).to_i

    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += quantity

    redirect_to cart_path
  end

  def update
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    if quantity <= 0
      session[:cart].delete(product_id)
    else
      session[:cart][product_id] = quantity
    end

    redirect_to cart_path
  end

  def remove
    product_id = params[:product_id].to_s
    session[:cart].delete(product_id)

    redirect_to cart_path
  end

  def clear
    session[:cart] = {}

    redirect_to cart_path
  end
end
