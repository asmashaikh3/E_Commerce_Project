require 'csv'
require 'open-uri'

namespace :seed_data do
  desc "Seed data from a CSV file"
  task from_csv: :environment do
    file_path = Rails.root.join('db', 'products.csv')
    
    CSV.foreach(file_path, headers: true) do |row|
      category_name = row['category_name']
      category = Category.find_or_create_by!(category_name: category_name)

      product = Product.create!(
        product_name: row['product_name'],
        description: row['description'],
        price: row['price'],
        stock_quantity: row['stock_quantity'],
        category: category
      )

      # Attach a random image from LoremFlickr
      begin
        image_url = "https://loremflickr.com/320/240/beer"
        file = URI.open(image_url)
        product.image.attach(io: file, filename: "#{product.product_name.downcase.gsub(' ', '_')}.jpg")
        puts "Attached image to product: #{product.product_name}"
      rescue => e
        puts "Failed to attach image to product: #{product.product_name} - Error: #{e.message}"
      end
    end

    puts "Seeding from CSV completed!"
  end
end
