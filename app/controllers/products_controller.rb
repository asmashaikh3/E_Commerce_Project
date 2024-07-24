class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:search].present?
      @products = @products.where("product_name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:filter] == 'on_sale'
      @products = @products.on_sale
    elsif params[:filter] == 'new'
      @products = @products.new_arrivals
    elsif params[:filter] == 'recently_updated'
      @products = @products.recently_updated
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
