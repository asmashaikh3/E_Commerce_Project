class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    if params[:search].present?
      @products = @products.where("product_name LIKE ?", "%#{params[:search]}%")
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:filter].present?
      if params[:filter] == 'on_sale'
        @products = @products.where(on_sale: true)
      elsif params[:filter] == 'new'
        @products = @products.order(created_at: :desc)
      elsif params[:filter] == 'recently_updated'
        @products = @products.order(updated_at: :desc)
      end
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
