class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :order_taxes, dependent: :destroy

  # Adding necessary fields with validations
  validates :subtotal_amount, :taxes, :total_amount, presence: true

  # Method to calculate taxes and total amount
  def calculate_taxes
    province = user.province # Assuming user has an associated province

    # Calculate the subtotal by summing up order item prices
    self.subtotal_amount = order_items.sum('price * quantity')

    # Calculate individual taxes based on the province
    gst = subtotal_amount * (province.gst / 100.0)
    pst = subtotal_amount * (province.pst / 100.0)
    hst = subtotal_amount * (province.hst / 100.0)
    qst = subtotal_amount * (province.qst / 100.0)

    # Sum of all taxes
    self.taxes = gst + pst + hst

    # Calculate the total amount (subtotal + taxes)
    self.total_amount = subtotal_amount + taxes
  end
end
