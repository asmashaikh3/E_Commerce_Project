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

# Ensure at least 300 products are created
current_product_count = Product.count
products_to_create = 300 - current_product_count

if products_to_create > 0
  products_to_create.times do
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
else
  puts "Already have 300 or more products in the database."
end

about_page = Page.find_or_create_by!(title: 'About Us')
about_page.update(content: <<-HTML
  <h1>About Artisanal Brews Co.</h1>
  <p>Welcome to Artisanal Brews Co., your premier destination for the finest craft beers and brewing kits. Founded in Winnipeg, Manitoba, we are a dedicated team of craft beer enthusiasts with a passion for brewing excellence.</p>
  
  <h2>Our Process</h2>
  <p>At Artisanal Brews Co., we believe that great beer starts with the finest ingredients. We source high-quality hops, malt, and yeast to create unique and flavorful brews. Our brewing process combines traditional techniques with modern innovations to produce beers that are both classic and cutting-edge.</p>
  
  <h2>Our Products</h2>
  <p>We offer a wide range of craft beers, each with its own distinct character. From hoppy IPAs to smooth stouts, our beers are crafted to suit every palate. For those who prefer to brew their own, our premium brewing kits provide everything you need to create exceptional beer at home.</p>
  
  <p>Cheers!</p>
  <p>The Artisanal Brews Co. Team</p>
HTML
)

contact_page = Page.find_or_create_by!(title: 'Contact Us')
contact_page.update(content: <<-HTML
  <h1>Contact Us</h1>
  <p>We'd love to hear from you! Whether you have questions about our products, need assistance with your order, or just want to share your feedback, our team is here to help.</p>
  
  <h2>Customer Service</h2>
  <p>Email: <a href="mailto:support@artisanalbrews.com">support@artisanalbrews.com</a><br>
     Phone: 1-800-123-4567<br>
     Hours: Monday to Friday, 9:00 AM - 5:00 PM CST</p>
  
  <h2>Connect with Us</h2>
  <p>Follow us on social media to stay updated on the latest news, events, and special offers:</p>
  <ul>
    <li>Facebook: @ArtBrewCraft</li>
    <li>Twitter: @ArtBrewCo</li>
    <li>Instagram: @ArtisanalBrew</li>
  </ul>
  
  <p>Thank you for choosing Artisanal Brews Co.!</p>
HTML
)
