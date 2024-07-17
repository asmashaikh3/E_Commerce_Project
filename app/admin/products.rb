ActiveAdmin.register Product do
  permit_params :product_name, :description, :price, :stock_quantity, :category_id

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
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
    actions
  end

  show do
    attributes_table do
      row :product_name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
