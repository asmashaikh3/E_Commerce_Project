ActiveAdmin.register Product do
  permit_params :product_name, :description, :price, :stock_quantity, :category_id, :image

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :product_name
    column :description
    column :price
    column :stock_quantity
    column :category
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "50x50"
      else
        "No Image"
      end
    end
    actions
  end

  show do
    attributes_table do
      row :product_name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :image do |product|
        image_tag url_for(product.image) if product.image.attached?
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  filter :product_name
  filter :category
  filter :price
  filter :created_at
end
