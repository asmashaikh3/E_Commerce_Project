require 'faker'
require 'open-uri'

# Create AdminUser only if it doesn't exist
if Rails.env.development? && AdminUser.where(email: 'admin@example.com').none?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

# Create initial categories if they don't exist
categories = ['IPA', 'Stout', 'Lager', 'Pilsner']
categories.each do |category_name|
  Category.find_or_create_by!(category_name: category_name)
end

# Get all categories
categories = Category.all

# Create initial products if they don't exist
unless Product.exists?
  products = [
    { product_name: 'Hoppy IPA', description: 'A deliciously hoppy IPA with citrus notes.', price: 4.99, stock_quantity: 100, category: categories.sample },
    { product_name: 'Smooth Stout', description: 'A smooth and creamy stout with hints of chocolate.', price: 5.99, stock_quantity: 50, category: categories.sample },
    { product_name: 'Crisp Lager', description: 'A crisp and refreshing lager perfect for any occasion.', price: 3.99, stock_quantity: 200, category: categories.sample },
    { product_name: 'Golden Pilsner', description: 'A golden pilsner with a perfect balance of malt and hops.', price: 4.49, stock_quantity: 150, category: categories.sample },
    { product_name: 'Amber Ale', description: 'A rich amber ale with a smooth finish.', price: 4.79, stock_quantity: 80, category: categories.sample },
    { product_name: 'Dark Porter', description: 'A dark porter with roasted malt flavors.', price: 5.29, stock_quantity: 60, category: categories.sample },
    { product_name: 'Blonde Ale', description: 'A light and easy-drinking blonde ale.', price: 3.49, stock_quantity: 120, category: categories.sample },
    { product_name: 'Wheat Beer', description: 'A refreshing wheat beer with hints of banana and clove.', price: 4.19, stock_quantity: 90, category: categories.sample },
    { product_name: 'Pale Ale', description: 'A classic pale ale with a balanced hop profile.', price: 4.39, stock_quantity: 110, category: categories.sample },
    { product_name: 'Sour Ale', description: 'A tart and tangy sour ale with fruity notes.', price: 5.49, stock_quantity: 70, category: categories.sample }
  ]

  products.each do |product_data|
    product = Product.create!(product_data)
    # Attach a random image to the product
    product.image.attach(
      io: URI.open('https://picsum.photos/200/300'), 
      filename: 'random.jpg'
    )
  end
end
