require 'nokogiri'
require 'httparty'

namespace :scrape do
  desc "Scrape products and categories from a third-party website"
  task products: :environment do
    url = 'https://example.com/products'
    response = HTTParty.get(url)
    document = Nokogiri::HTML(response.body)

    # Example: Scraping categories
    document.css('.category').each do |category_element|
      category_name = category_element.text.strip
      category = Category.find_or_create_by!(category_name: category_name)
      
      # Example: Scraping products within the category
      category_element.css('.product').each do |product_element|
        product_name = product_element.css('.product-name').text.strip
        description = product_element.css('.product-description').text.strip
        price = product_element.css('.product-price').text.strip.gsub('$', '').to_f
        stock_quantity = product_element.css('.product-stock').text.strip.to_i

        product = Product.find_or_create_by!(
          product_name: product_name,
          description: description,
          price: price,
          stock_quantity: stock_quantity,
          category: category
        )

        # Optionally scrape and attach product images
        image_url = product_element.css('.product-image').attr('src').value
        file = URI.open(image_url)
        product.image.attach(io: file, filename: "#{product_name.downcase.gsub(' ', '_')}.jpg")
      end
    end

    puts "Scraping complete!"
  end
end
