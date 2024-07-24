class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items
  has_one_attached :image

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_arrivals, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago) }

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "price", "product_name", "stock_quantity", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
