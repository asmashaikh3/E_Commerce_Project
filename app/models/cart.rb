class Cart
  attr_reader :items

  def initialize(session)
    @session = session
    @items = session[:cart] || []
  end

  def add_product(product_id)
    @items << product_id
    @session[:cart] = @items
  end

  def remove_product(product_id)
    @items.delete(product_id)
    @session[:cart] = @items
  end

  def clear
    @items = []
    @session[:cart] = @items
  end

  def products
    Product.find(@items)
  end
end
