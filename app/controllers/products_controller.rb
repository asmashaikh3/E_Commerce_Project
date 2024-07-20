class ProductsController < ApplicationController
  def index
    @categories = Category.all

    if params[:category_id].present?
      @products = Product.where(category_id: params[:category_id])
    else
      @products = Product.all
    end

    if params[:search].present?
      @products = @products.where("product_name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
