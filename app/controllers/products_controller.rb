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

    if params[:filter].present?
      case params[:filter]
      when 'on_sale'
        @products = @products.where(on_sale: true)
      when 'new'
        @products = @products.where('created_at >= ?', 3.days.ago)
      when 'recently_updated'
        @products = @products.where('updated_at >= ?', 3.days.ago).where('created_at < ?', 3.days.ago)
      end
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
