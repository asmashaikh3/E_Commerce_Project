ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :address

  index do
    selectable_column
    id_column
    column :email
    column :address
    column :encrypted_password
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :address
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :address
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :address
      row :encrypted_password
      row :created_at
      row :updated_at
    end
  end
end
