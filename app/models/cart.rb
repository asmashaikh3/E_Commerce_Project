class Cart
  attr_reader :items

  def initialize(session)
    @session = session
    @items = session[:cart] || {}
  end

  def add_product(product_id)
    @items[product_id.to_s] ||= 0
    @items[product_id.to_s] += 1
    @session[:cart] = @items
  end

  def update_product(product_id, quantity)
    @items[product_id.to_s] = quantity
    @session[:cart] = @items
  end

  def remove_product(product_id)
    @items.delete(product_id.to_s)
    @session[:cart] = @items
  end

  def clear
    @items = {}
    @session[:cart] = @items
  end

  def products
    Product.find(@items.keys)
  end
end
