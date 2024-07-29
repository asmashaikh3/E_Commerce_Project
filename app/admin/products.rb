ActiveAdmin.register Product do
  permit_params :product_name, :description, :price, :stock_quantity, :category_id, :on_sale, :image

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :on_sale
      f.input :image, as: :file
    end
    f.actions
  end

  filter :product_name
  filter :description
  filter :price
  filter :stock_quantity
  filter :category
  filter :created_at
  filter :updated_at
  filter :on_sale
end
