class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :category

  # For attaching images
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[id product_name description price stock_quantity category_id created_at updated_at on_sale]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category order_items orders]
  end
end
