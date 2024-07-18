ActiveAdmin.register Page do
    permit_params :title, :content
  
    form do |f|
      f.inputs do
        f.input :title, input_html: { readonly: true }
        f.input :content
      end
      f.actions
    end
  
    show do
      attributes_table do
        row :title
        row :content do |page|
          raw(page.content) # Allows rendering HTML content
        end
      end
      active_admin_comments
    end
  
    index do
      selectable_column
      id_column
      column :title
      actions
    end
  
    filter :title
  end
  