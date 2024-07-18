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
  20.times do
    product = Product.create!(
      product_name: Faker::Beer.name,
      description: Faker::Beer.style,
      price: Faker::Commerce.price(range: 3.0..100.0),
      stock_quantity: Faker::Number.between(from: 50, to: 200),
      category: categories.sample
    )
    
    # Attach a random image to the product
    begin
      image_url = Faker::LoremFlickr.image(size: "200x300", search_terms: ['beer'])
      file = URI.open(image_url)
      product.image.attach(io: file, filename: "#{product.product_name.downcase.gsub(' ', '_')}.jpg")
      puts "Attached image to product: #{product.product_name}"
    rescue => e
      puts "Failed to attach image to product: #{product.product_name} - Error: #{e.message}"
    end
  end
end
