ActiveAdmin.register Category do
    permit_params :category_name
  
    index do
      selectable_column
      id_column
      column :category_name
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :category_name
      end
      f.actions
    end
  
    show do
      attributes_table do
        row :category_name
        row :created_at
        row :updated_at
      end
      active_admin_comments
    end
  
    filter :category_name
    filter :created_at
  end
  