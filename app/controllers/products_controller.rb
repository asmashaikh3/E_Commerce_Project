class ProductsController < ApplicationController
  def index
    @categories = Category.all

    if params[:search].present? && params[:category_id].present?
      @products = Product.where("product_name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").where(category_id: params[:category_id])
    elsif params[:search].present?
      @products = Product.where("product_name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    elsif params[:category_id].present?
      @products = Product.where(category_id: params[:category_id])
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
